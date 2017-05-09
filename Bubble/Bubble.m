//
//  Bubble.m
//  Bubble
//
//  Created by wangyunwen on 17/5/8.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "Bubble.h"

NSMutableDictionary * bubbles;

@implementation Bubble : NSObject

+ (void)initialize {
    bubbles = [[NSMutableDictionary alloc] init];
    
    Bubble *red = [[Bubble alloc] init];
    red.color = @"red";
    red.gamePoint = 1;
    red.probability = 0.4;
    [bubbles setObject:red forKey:red.color];
    
    Bubble *pink = [[Bubble alloc] init];
    pink.color = @"pink";
    pink.gamePoint = 2;
    pink.probability = 0.3;
    [bubbles setObject:pink forKey:pink.color];
    
    Bubble *green = [[Bubble alloc] init];
    green.color = @"green";
    green.gamePoint = 5;
    green.probability = 0.15;
    [bubbles setObject:green forKey:green.color];
    
    Bubble *blue = [[Bubble alloc] init];
    blue.color = @"blue";
    blue.gamePoint = 8;
    blue.probability = 0.1;
    [bubbles setObject:blue forKey:blue.color];
    
    Bubble *black = [[Bubble alloc] init];
    black.color = @"black";
    black.gamePoint = 10;
    black.probability = 0.05;
    [bubbles setObject:black forKey:black.color];
    
}

+(Bubble*) bubbleForColor:(NSString*)color {
    return [bubbles objectForKey:color];
}


@end
