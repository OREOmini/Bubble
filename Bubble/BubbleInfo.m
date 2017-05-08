//
//  BubbleInfo.m
//  Bubble
//
//  Created by wangyunwen on 17/5/8.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "BubbleInfo.h"

NSMutableDictionary * bubbles;

@implementation BubbleInfo : NSObject

+ (void)initialize {
    bubbles = [[NSMutableDictionary alloc] init];
    
    BubbleInfo *red = [[BubbleInfo alloc] init];
    red.color = @"red";
    red.gamePoint = 1;
    red.probability = 0.4;
    
    BubbleInfo *pink = [[BubbleInfo alloc] init];
    pink.color = @"pink";
    pink.
    BubbleInfo *green = [[BubbleInfo alloc] init];

    BubbleInfo *blue = [[BubbleInfo alloc] init];

    BubbleInfo *black = [[BubbleInfo alloc] init];

}

@end
