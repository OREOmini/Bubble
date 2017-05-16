//
//  Player+CoreDataProperties.h
//  Bubble
//
//  Created by wangyunwen on 17/5/16.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "Player+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Player (CoreDataProperties)

+ (NSFetchRequest<Player *> *)fetchRequest;

@property (nonatomic) int16_t bubble_number;
@property (nonatomic) int16_t game_time;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t score;

@end

NS_ASSUME_NONNULL_END
