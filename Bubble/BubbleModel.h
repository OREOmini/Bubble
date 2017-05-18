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

// choose colors with possiblity
-(NSMutableArray*)chooseRandomColorsWithNumber:(int)num;

// generate an array of bubble rect that will not overlap each other and will not overlap existing bubbles
-(NSMutableArray*) generateBubblePositionsWithFrame:(CGRect)frame
                                    withRequiredNum:(int)num
                                 andExistingBubbles:(NSMutableArray*) existingBubbles;

@end
