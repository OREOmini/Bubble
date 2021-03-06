//
//  Bubble.h
//  Bubble
//
//  Created by wangyunwen on 17/5/8.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bubble : NSObject

@property NSString *color;
@property int gamePoint;
@property double probability;

+(Bubble*) bubbleForColor:(NSString*)color;

@end
