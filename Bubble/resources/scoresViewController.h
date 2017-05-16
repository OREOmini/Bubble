//
//  scoresViewController.h
//  Bubble
//
//  Created by wangyunwen on 17/5/16.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scoresViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *scoreTableView;

@end
