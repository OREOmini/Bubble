//
//  BubbleViewController.m
//  Bubble
//
//  Created by wangyunwen on 17/5/7.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "BubbleViewController.h"
#import "BubbleModel.h"
#import "GameOverViewController.h"
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>


static const int SHOW_BUBBLE_SCORE_LABEL_TAG = 20;

@interface BubbleViewController () {
    NSTimer *timer;
    AppDelegate * appDelegate;
}

@end

// an array to store all the exit bubbles
static NSMutableArray *existBubbles;
static BubbleModel *bubbleModel;

@implementation BubbleViewController

@synthesize timeLabel;
@synthesize userName;
@synthesize gameTime;
@synthesize bubbleNumber;
@synthesize bubbleView;
@synthesize highestSocre;
@synthesize score;
@synthesize bubbleSize;
@synthesize lastBubbleTag;
@synthesize timeProgressView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    highestSocre.text = [NSString stringWithFormat:@"%d", appDelegate.getHighestScore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    self.timeLabel.text = gameTime;
     self.timeLabel.tag = [gameTime intValue]; // tag is like an integer scratchpad
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES]; //sets up the timer of 1 sec interval
    
    bubbleSize = [self calculateBubbleSize];
    // NSLog(@"%f",bubbleSize);
    lastBubbleTag = INT_MAX;
    existBubbles = [[NSMutableArray alloc]init];
    
    bubbleModel = [[BubbleModel alloc] init];
    [bubbleModel setBubbleNumber:[bubbleNumber intValue]];
    [bubbleModel setBubbleSize: bubbleSize];

    [self showBubbles];

}

// adjust different bubble size based on screen size and bubble number
-(float) calculateBubbleSize{
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float temp = (width > height) ? height : width;
    return (temp / sqrt([bubbleNumber intValue])) * 0.8;
}

#pragma mark - Show bubbles

/* randomly generate a number of bubbles will show up based on exiting bubbles and maximal bubble number
 generate these bubbles position and colors(with possiblity) randomly and show bubbles with animation*/
- (void) showBubbles {
    
    // randomly generate number of bubble will show up
    int willShowBubbleNumber = arc4random() % (int) ([bubbleNumber intValue] - existBubbles.count);
    
    NSMutableArray *pos = [[NSMutableArray alloc] initWithArray:[bubbleModel
                                                                 generateBubblePositionsWithFrame:bubbleView.frame
                                                                 withRequiredNum:willShowBubbleNumber andExistingBubbles:existBubbles]];
    NSMutableArray *colors = [[NSMutableArray alloc]
                              initWithArray:[bubbleModel chooseRandomColorsWithNumber:willShowBubbleNumber]];
    
    for(int i = 0; i < willShowBubbleNumber; i++) {
        CGRect rect = [[pos objectAtIndex:i] CGRectValue];
        if(!CGRectIsNull(rect)) {
            [existBubbles addObject:[NSValue valueWithCGRect:rect]];
            UIButton *button = [self createBubbleButtonWithColor:[colors objectAtIndex:i] withRect:rect];
            
            
            button.transform = CGAffineTransformMakeScale(0.1, 0.1);
            [UIView animateWithDuration:0.3 animations:^() {
                button.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
            
            [bubbleView addSubview:button];
        }
    }
}

// give a UIButton with specific color and rect
-(UIButton*) createBubbleButtonWithColor:(NSString*)color withRect:(CGRect)rect {
    NSString *imageName = [NSString stringWithFormat:@"%@_bubble.png", color];
    
    UIButton *bubble = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bubble.frame = rect;
    [bubble setTitle:@"" forState:UIControlStateNormal];
    [bubble addTarget:self action:@selector(touchBubble:) forControlEvents:UIControlEventTouchUpInside];
    [bubble setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSInteger point = [[Bubble bubbleForColor:color] gamePoint];
    //[bubble setValue:[NSNumber numberWithInteger:point] forKey:@"point"];
    [bubble setTag:point];
    
    return bubble;
}

#pragma mark - when touch a bubble

// remove bubble from screen and bubble array
// show gained point and add to total point
- (IBAction)touchBubble:(UIButton*)bubble {
    //NSLog(@"BUBBLE %f %f", bubble.currentBackgroundImage., );
    
    Boolean isExtraPoint = [self isSequenceBubble:bubble];
    int point = (int)bubble.tag;
    if (isExtraPoint) point = round(point*1.5);
    [score setText:[NSString stringWithFormat:@"%d", point+[score.text intValue]]];
    [self popGainedScoreWithPoint:point andBubble:(UIButton*)bubble withFlag:(Boolean)isExtraPoint];
    
    [self playPopSound];
    [bubble removeFromSuperview];
    [existBubbles removeObject:[NSValue valueWithCGRect:bubble.frame]];
}

// play sound effect when touching a bubble
-(void) playPopSound {
    SystemSoundID soundID;
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"pop" ofType:@"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

// determine if the bubble is with sequence extra point by seeing if the last bubble and current bubble's tag is the same value
// if is not, set last touched bubble's tag INT_MAX
-(Boolean) isSequenceBubble:(UIButton*)bubble {
    // If two or more bubbles of the same colour are popped in a consecutive sequence
    // the bubbles after the first one will get 1.5 times of their original game points
    int s = (int)bubble.tag;
    if(lastBubbleTag == INT_MAX) {
        lastBubbleTag = (int) bubble.tag;
        return false;
    } else {
        if(lastBubbleTag == s) {
            return true;
        } else {
            lastBubbleTag = s;
            return false;
        }
    }
}

// show gained point, if is extra point show with different format
-(void) popGainedScoreWithPoint:(int)point andBubble:(UIButton*)bubble withFlag:(Boolean)isExtraPoint {
    CGRect rect = CGRectMake(bubble.center.x - 50, bubble.center.y-50, 120, 100);
    UILabel *bubbleScoreLabel = [[UILabel alloc]initWithFrame:rect];
    bubbleScoreLabel.textAlignment = NSTextAlignmentCenter;
    NSString *msg;
    
    if(isExtraPoint) {
        bubbleScoreLabel.textColor = [UIColor colorWithHue:0.05 saturation:0.77 brightness:0.75 alpha:1];
        bubbleScoreLabel.numberOfLines = 2;
        msg = [NSString stringWithFormat:@"COMBO!x1.5 +%d", (int)point];
    } else {
        bubbleScoreLabel.textColor = [UIColor darkGrayColor];
        msg = [NSString stringWithFormat:@"+%d", (int)point];
    }
    bubbleScoreLabel.text = msg;
    bubbleScoreLabel.tag = SHOW_BUBBLE_SCORE_LABEL_TAG;
    [bubbleView addSubview:bubbleScoreLabel];
    
    [UIView animateWithDuration:0.3 delay:1 options:0 animations:^{
        bubbleScoreLabel.alpha = 0;
    } completion:^(BOOL finished) {
        bubbleScoreLabel.hidden = YES;
        [bubbleScoreLabel removeFromSuperview];
    }];
}


#pragma mark - remove random bubbles

// randomly generate a number of bubbles will be removed based on exiting bubbles and maximal bubble number
// and remove them with animation
- (void) removeBubbles {
    NSMutableArray * bubbles = [[NSMutableArray alloc] init];
    for(UIView* bubble in bubbleView.subviews)
        if(bubble.tag != SHOW_BUBBLE_SCORE_LABEL_TAG)
            [bubbles addObject:bubble];
    if(existBubbles.count > 0) {
        int randomRemoveNumber = arc4random() % (int) (existBubbles.count);
        if(randomRemoveNumber > 0 && randomRemoveNumber < (int)existBubbles.count) {
            for(int i = 0; i < randomRemoveNumber; i++) {
                int ran = arc4random() % existBubbles.count;
                UIView * temp = [bubbles objectAtIndex:ran];
                [bubbles removeObjectAtIndex:ran];
                
                //            temp.transform = CGAffineTransformMakeScale(0.1, 0.1);
                [UIView animateWithDuration:0.3 animations:^() {
                    temp.transform = CGAffineTransformMakeScale(0.1, 0.1);
                }completion:^(BOOL finish) {
                    [temp removeFromSuperview];
                }];
                
                if(ran < existBubbles.count)
                    [existBubbles removeObjectAtIndex:ran];
            }
        }
    }
}



#pragma mark - timer function
- (void) updateTimer
{
    int tl = (int)self.timeLabel.tag - 1;
    
    if (tl <= 0) {
        [timer invalidate]; //cancel the timer
        timer = nil;
        [self performSegueWithIdentifier:@"gameOver" sender:nil];
        
    }
    else {
        self.timeLabel.text = [NSString stringWithFormat: @"%d", tl];
        self.timeLabel.tag = tl;
        timeProgressView.progress -= 1.0/ [gameTime floatValue];
    }
    
    [self removeBubbles];
    [self showBubbles];
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    GameOverViewController *des = segue.destinationViewController;
    des.userName = userName;
    des.bubbleNumber = bubbleNumber;
    des.gameTime = gameTime;
    des.score = [score.text intValue];
    
    
}


@end
