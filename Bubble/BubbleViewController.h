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

@property (weak, nonatomic) IBOutlet UIProgressView *timeProgressView;


-(IBAction)touchBubble:(UIButton*)bubble;
-(Boolean) isSequenceBubble:(UIButton*)bubble;
-(void) popGainedScoreWithPoint:(int)point andBubble:(UIButton*)bubble withFlag:(Boolean)isExtraPoint;
-(void) removeBubbles;
-(void) updateTimer;
-(UIButton*) createBubbleButtonWithColor:(NSString*)color withRect:(CGRect)rect;


@end
