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

static const int BUBBLE_SIZE = 80;

@interface BubbleViewController () {
    NSTimer *timer;
}

@end

@implementation BubbleViewController

@synthesize timeLabel;
@synthesize userName;
@synthesize gameTime;
@synthesize bubbleNumber;
@synthesize bubbleView;
@synthesize highestSocre;
@synthesize score;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    self.timeLabel.text = gameTime;
     self.timeLabel.tag = [gameTime intValue]; // tag is like an integer scratchpad
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES]; //sets up the timer of 1 sec interval
    
    [self showBubbles];

}

- (void) showBubbles {
    BubbleModel *bubbleModel;
    bubbleModel = [[BubbleModel alloc] init];
    [bubbleModel setBubbleNumber:[bubbleNumber intValue]];
    [bubbleModel setBubbleSize: BUBBLE_SIZE];
    NSLog(@"%d", [bubbleModel bubbleNumber]);
    // NSMutableArray *t = [bubbleModel generateBubblePositions];
    
    NSMutableArray *pos = [[NSMutableArray alloc] initWithArray:[bubbleModel generateBubblePositionsWithFrame:bubbleView.frame]];
    NSMutableArray *colors = [[NSMutableArray alloc] initWithArray:[bubbleModel generateBubbleColors]];
    
    
    for(int i = 0; i < [bubbleNumber intValue]; i++) {
        CGRect rect = [[pos objectAtIndex:i] CGRectValue];
        UIButton *button = [self createBubbleButtonWithColor:[colors objectAtIndex:i]
                                                         withRect:rect];
        // NSLog(@"%@ at %f", [colors objectAtIndex:i], rect.size);
        [bubbleView addSubview:button];
    }
    //[self.view addSubview:blueBubble];
}

- (IBAction)touchBubble:(UIButton*)bubble {
    NSLog(@"BUBBLE %f %f", bubble.center.x, bubble.center.y);
    
    int s = [score.text intValue] + (int)bubble.tag;
    [score setText:[NSString stringWithFormat:@"%d", s]];
    [bubble removeFromSuperview];
}

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
    }
    
    //[self removeBubbles];
    for(UIView* bubble in bubbleView.subviews)
        [bubble removeFromSuperview];
    [self showBubbles];
}

-(UIButton*) createBubbleButtonWithColor:(NSString*)color withRect:(CGRect)rect {
    NSString *imageName = [NSString stringWithFormat:@"%@_bubble.png", color];
    
    UIButton *bubble = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bubble.frame = rect;
    [bubble setTitle:@"" forState:UIControlStateNormal];
    [bubble addTarget:self action:@selector(touchBubble:) forControlEvents:UIControlEventTouchUpInside];
    [bubble setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSInteger tag = [[Bubble bubbleForColor:color] gamePoint];
    [bubble setTag:tag];
    
    return bubble;
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
