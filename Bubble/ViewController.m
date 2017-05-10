//
//  ViewController.m
//  Bubble
//
//  Created by wangyunwen on 17/5/7.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "ViewController.h"
#import "BubbleViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize nameField;
@synthesize startBtn;
@synthesize bubbleNumberLabel;
@synthesize gameTimeSlider;
@synthesize bubbleNumberSlider;
@synthesize gameTimeLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BubbleViewController *des = segue.destinationViewController;
    des.userName = nameField.text;
    des.gameTime = [NSString stringWithFormat:@"%d", (int)gameTimeSlider.value];
    des.bubbleNumber = [NSNumber numberWithInt:(int)bubbleNumberSlider.value];
}


- (IBAction)startGame:(id)sender {
}
- (IBAction)gameTimeSliderChange:(id)sender {
    gameTimeLabel.text = [NSString stringWithFormat:@"%d", (int)gameTimeSlider.value];
}

- (IBAction)bubbleNumberSliderChange:(id)sender {
    bubbleNumberLabel.text = [NSString stringWithFormat:@"%d", (int)bubbleNumberSlider.value];
}
@end
