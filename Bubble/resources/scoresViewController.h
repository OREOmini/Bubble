//
//  scoresViewController.h
//  Bubble
//
//  Created by wangyunwen on 17/5/16.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreList.h"

@interface scoresViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *scoreTableView;
@property (strong, nonatomic) HighScoreList *highScoreList;

@end
