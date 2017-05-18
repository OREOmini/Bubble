//
//  ViewController.m
//  Bubble
//
//  Created by wangyunwen on 17/5/7.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "ViewController.h"
#import "BubbleViewController.h"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ViewController () {
    NSTimer *timer;
}

@end

@implementation ViewController

@synthesize nameField;
@synthesize startBtn;
@synthesize bubbleNumberLabel;
@synthesize gameTimeSlider;
@synthesize bubbleNumberSlider;
@synthesize gameTimeLabel;


// for the count down animation
int countdown_time;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer * tapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handleBackgroundTap:)];


    tapRecogniser.cancelsTouchesInView = NO;
    countdown_time = 3;
    [self.view addGestureRecognizer:tapRecogniser];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"start_game"]) {
        BubbleViewController *des = segue.destinationViewController;
        des.userName = nameField.text;
        des.gameTime = [NSString stringWithFormat:@"%d", (int)gameTimeSlider.value];
        des.bubbleNumber = [NSNumber numberWithInt:(int)bubbleNumberSlider.value];
    }
}


- (IBAction)startGame:(id)sender {
    [self onDismissKeyboard:sender];
    
    NSString *username = nameField.text;
    if(username.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Player Name"
                                                                       message:@"Please enter player name"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction* action) {}];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
       
    } else {
        [self showCountDownAnimation];
    }
}

// show 3 2 1 countdown and then go to game scene
- (void) showCountDownAnimation {
    for(UIView *view in self.view.subviews) {
        [view setHidden:YES];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}
- (void) updateTimer {
    if(countdown_time >= 0) {
        [self createCountDownPageWithTime:countdown_time];
        countdown_time--;
    } else {
        [timer invalidate];
        timer = nil;
        [self performSegueWithIdentifier:@"start_game" sender:nil];
    }
}
- (void) createCountDownPageWithTime:(int)time {
    CGRect rect = CGRectMake(self.view.center.x-150, self.view.center.y-150, 300, 300);
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:140 weight:700]];
    [label setTextColor:UIColorFromRGB(0xcb585b)];
    if (countdown_time > 0)
        label.text = [NSString stringWithFormat:@"%d", countdown_time];
    else
        label.text = [NSString stringWithFormat:@"GO!"];
    [UIView animateWithDuration:0.6
                     animations:^() {
                         [self.view addSubview:label];
                         label.alpha = 0;
                         label.transform = CGAffineTransformMakeScale(0.1, 0.1);
                     }
                     completion:^(BOOL finish){
                         [label removeFromSuperview];

    }];
}


// handle sliders change
- (IBAction)gameTimeSliderChange:(id)sender {
    gameTimeLabel.text = [NSString stringWithFormat:@"%d", (int)gameTimeSlider.value];
}

- (IBAction)bubbleNumberSliderChange:(id)sender {
    bubbleNumberLabel.text = [NSString stringWithFormat:@"%d", (int)bubbleNumberSlider.value];
}

- (IBAction)onDismissKeyboard:(id)sender {
    [nameField resignFirstResponder];
}

- (void)handleBackgroundTap:(UITapGestureRecognizer*) sender {
    [self onDismissKeyboard:sender];
}
@end
