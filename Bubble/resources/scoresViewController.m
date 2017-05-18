//
//  scoresViewController.m
//  Bubble
//
//  Created by wangyunwen on 17/5/16.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "scoresViewController.h"
#import "AppDelegate.h"
#import "Player+CoreDataProperties.h"
#import "HighScoreList.h"
#import  "QuartzCore/QuartzCore.h"

@interface scoresViewController () 

@end

@implementation scoresViewController

@synthesize scoreTableView;
@synthesize highScoreList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    scoreTableView.layer.borderWidth = 2;
    scoreTableView.layer.borderColor = [UIColor redColor].CGColor;
    highScoreList = [[HighScoreList alloc] getData];
    
    self.scoreTableView.delegate = highScoreList;
    self.scoreTableView.dataSource = highScoreList;


    [self.scoreTableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
