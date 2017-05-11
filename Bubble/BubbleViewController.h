//
//  BubbleViewController.h
//  Bubble
//
//  Created by wangyunwen on 17/5/7.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleModel.h"
#import "GameOverViewController.h"

@interface BubbleViewController : UIViewController

@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property NSString *gameTime;
@property NSNumber *bubbleNumber;
@property float bubbleSize;
@property int lastBubbleTag;
@property (weak, nonatomic) IBOutlet UIView *bubbleView;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *highestSocre;

-(IBAction)touchBubble:(UIButton*)sender;
-(UIButton*) createBubbleButtonWithColor:(NSString*)color withRect:(CGRect)rect;

@end
