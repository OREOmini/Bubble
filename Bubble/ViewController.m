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
    des.gameTime = @"5";
    des.bubbleNumber = @15;
}


- (IBAction)startGame:(id)sender {
}
@end
