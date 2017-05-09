//
//  GameOverViewController.m
//  Bubble
//
//  Created by wangyunwen on 17/5/7.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "GameOverViewController.h"
#import "BubbleViewController.h"

@interface GameOverViewController ()

@end

@implementation GameOverViewController

@synthesize gameTime;
@synthesize score;
@synthesize bubbleNumber;
@synthesize userName;
@synthesize showScoreLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    showScoreLabel.text = [NSString stringWithFormat:@"%@, your socre is %d", userName, score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    BubbleViewController *des = segue.destinationViewController;
//    des.userName = userName;
//    des.bubbleNumber = bubbleNumber;
//    des.gameTime = gameTime;
//}


- (IBAction)goToViewController:(id)sender {
    [self performSegueWithIdentifier:<#(nonnull NSString *)#> sender:<#(nullable id)#>]
    //[self prepareForSegue: sender:<#(nullable id)#>]
}
@end
