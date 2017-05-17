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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addCurrentScoreToCoredata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    appDelegate_ = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    scoreList_ = [appDelegate_ scoreList];
    
    highScoreList = [[HighScoreList alloc] getData];
    
    self.scoreTableView.delegate = highScoreList;
    self.scoreTableView.dataSource = highScoreList;
    
    [self.scoreTableView reloadData];
    
    showScoreLabel.text = [NSString stringWithFormat:@"%@, your socre is %d", userName, score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addCurrentScoreToCoredata {
    if (scoreList_.count < 10)
        scoreList_ = [appDelegate_ addNewPlayer:userName score:[NSNumber numberWithInt:score] bubbleNumber:bubbleNumber gameTime:[NSNumber numberWithInt:[gameTime intValue]]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if(sender == _goBackToMenuBtn) {
//        ViewController *des = segue.destinationViewController;
//    }
    if(sender == _restartBtn) {
        BubbleViewController *des = segue.destinationViewController;
        des.userName = userName;
        des.bubbleNumber = bubbleNumber;
        des.gameTime = gameTime;

    }
}



@end
