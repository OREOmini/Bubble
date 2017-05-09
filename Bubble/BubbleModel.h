//
//  BubbleModel.h
//  Bubble
//
//  Created by wangyunwen on 17/5/8.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Bubble.h"


@interface BubbleModel : NSObject

@property NSDictionary *bubbles;
@property int bubbleNumber;
@property int bubbleSize;

-(CGRect) generateRandomRectInFrame:(CGRect)frame;
-(NSMutableArray*) generateBubblePositionsWithFrame:(CGRect)frame;
-(NSMutableArray*) generateBubbleColors;

@end
