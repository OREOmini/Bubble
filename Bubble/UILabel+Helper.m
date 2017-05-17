//
//  UILabel+Helper.m
//  Bubble
//
//  Created by wangyunwen on 17/5/17.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
    self.font = [UIFont fontWithName:name size:self.font.pointSize]; }

@end
