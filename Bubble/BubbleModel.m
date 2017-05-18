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


// give a maximal attempt time
static const int MAX_TRYING_TIME = 100;


@implementation BubbleModel

@synthesize bubbleNumber;
@synthesize bubbleSize;


// give a random bubble rect within a frame
-(CGRect) generateRandomRectInFrame:(CGRect)frame {
    CGRect rect;
    CGFloat x = (CGFloat) (arc4random() % (int) (frame.size.width - bubbleSize));
    CGFloat y = (CGFloat) (arc4random() % (int) (frame.size.height - bubbleSize));
    rect = CGRectMake(x, y, bubbleSize, bubbleSize);
    return rect;
}

// see if current rect intersects an array of rects
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
-(NSMutableArray*) generateBubblePositionsWithFrame:(CGRect)frame
                                    withRequiredNum:(int)num
                                 andExistingBubbles:(NSMutableArray*) existingBubbles{
    NSMutableArray *bubblePositions = [[NSMutableArray alloc] init];
    for (int i = 0; i < num; i++) {
        CGRect rect = [self generateRandomRectInFrame:frame];
        
        // if attempt times > maximal attempt time, give a CGRectNull
        int attemp_times = 0;
        while(([self rect:rect hasIntersectionInPos:bubblePositions]
               || [self rect:rect hasIntersectionInPos:existingBubbles])
              && attemp_times <= MAX_TRYING_TIME) {
            rect = [self generateRandomRectInFrame:frame];
            attemp_times++;
        }
        if(attemp_times >= MAX_TRYING_TIME) rect = CGRectNull;
        [bubblePositions addObject:[NSValue valueWithCGRect:rect]];
    }
    return bubblePositions;
}


-(NSMutableArray*)chooseRandomColorsWithNumber:(int)num {
    NSMutableArray* colors = [self generateBubbleColors];
    NSMutableArray* chosenColors = [[NSMutableArray alloc] init];
    for(int i = 0; i < num; i++) {
        int ran = (arc4random() % (int)bubbleNumber);
        [chosenColors addObject:[colors objectAtIndex:ran]];
    }
    return chosenColors;
}

// an color array based on the maximal bubble number and color's possiblity
// each color has a number of floor(bubbleNumber * color probability]) objects
// and the rest will be red
-(NSMutableArray*) generateBubbleColors {
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
// based on the maximal bubble number and color's possiblity
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
