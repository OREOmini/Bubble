//
//  GameOverViewController.m
//  Bubble
//
//  Created by wangyunwen on 17/5/7.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "GameOverViewController.h"
#import "BubbleViewController.h"
#import "ViewController.h"
#include "AppDelegate.h"
#include "Player+CoreDataProperties.h"

@interface GameOverViewController () {
    NSMutableArray *scoreList_;
    AppDelegate * appDelegate_;
}

@end

@implementation GameOverViewController

@synthesize gameTime;
@synthesize score;
@synthesize bubbleNumber;
@synthesize userName;
@synthesize showScoreLabel;
@synthesize scoreTableView;
@synthesize highScoreList;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    appDelegate_ = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // add current player's score to coredata
    scoreList_ = [appDelegate_ addNewPlayer:userName score:[NSNumber numberWithInt:score] bubbleNumber:bubbleNumber gameTime:[NSNumber numberWithInt:[gameTime intValue]]];
    
    
    highScoreList = [[HighScoreList alloc] getData];
    self.scoreTableView.delegate = highScoreList;
    self.scoreTableView.dataSource = highScoreList;
    
    [self.scoreTableView reloadData];
    
    showScoreLabel.text = [NSString stringWithFormat:@"%d", score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(sender == _restartBtn) {
        BubbleViewController *des = segue.destinationViewController;
        des.userName = userName;
        des.bubbleNumber = bubbleNumber;
        des.gameTime = gameTime;

    }
}



@end
