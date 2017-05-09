//
//  BubbleModel.m
//  Bubble
//
//  Created by wangyunwen on 17/5/8.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleModel.h"
#import "Bubble.h"


@implementation BubbleModel

@synthesize bubbleNumber;
@synthesize bubbleSize;

-(CGRect) generateRandomRectInFrame:(CGRect)frame {
    CGRect rect;
    CGFloat x = (CGFloat) (arc4random() % (int) (frame.size.width - bubbleSize));
    CGFloat y = (CGFloat) (arc4random() % (int) (frame.size.height - bubbleSize));
    rect = CGRectMake(x, y, bubbleSize, bubbleSize);
    return rect;
}

-(BOOL) rect:(CGRect)rect hasIntersectionInPos:(NSMutableArray*)pos {
    if(pos.count > 0) {
        for(int i = 0; i < pos.count; i++) {
            CGRect existRect = [[pos objectAtIndex:i] CGRectValue];
            if (CGRectIntersectsRect(existRect, rect))
                return true;
        }
    }
    return false;
}

-(NSMutableArray*) generateBubblePositionsWithFrame:(CGRect)frame {
    NSMutableArray *bubblePositions = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < bubbleNumber; i++) {
        CGRect rect = [self generateRandomRectInFrame:frame];
        while ([self rect:rect hasIntersectionInPos:bubblePositions]) {
            rect = [self generateRandomRectInFrame:frame];
        }
        [bubblePositions addObject:[NSValue valueWithCGRect:rect]];
    }

    
    return bubblePositions;
}
-(NSMutableArray*) generateBubbleColors {
    bubbleNumber = 15;
    NSArray *colors = [[NSArray alloc] initWithObjects:@"red", @"green", @"blue", @"pink", @"black",nil];
    NSMutableArray *bubbleColors = [[NSMutableArray alloc] init];
    
    for(id color in colors) {
        [bubbleColors addObjectsFromArray:[self plainColorArray:color]];
    }
    int left = bubbleNumber - (int)bubbleColors.count;
    if(left > 0) {
        for(int i = 0; i < left; i++)
            [bubbleColors addObject:@"red"];
    }
    return bubbleColors;
}

// create a string array with one color for "generateBubbleColors" func
-(NSMutableArray*) plainColorArray:(NSString*)color  {
    int num = floor(bubbleNumber * [[Bubble bubbleForColor:color] probability]);
    // make sure there will be at least one of this color
    if(num == 0)
        num = 1;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < num; i++) {
        [array addObject:color];
    }
    return array;
}

@end
