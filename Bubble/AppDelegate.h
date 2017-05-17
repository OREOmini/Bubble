//
//  AppDelegate.h
//  Bubble
//
//  Created by wangyunwen on 17/5/7.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    @private
    NSMutableArray * knownScoreList_;
    NSArray * sortDescriptors_;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

- (NSMutableArray*)addNewPlayer:(NSString*)name score:(NSNumber*)score bubbleNumber:(NSNumber*)bubble_number gameTime:(NSNumber*) game_time;
- (NSMutableArray*)scoreList;
- (int)getHighestScore;

@end

