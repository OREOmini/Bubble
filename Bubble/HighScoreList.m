//
//  HighScoreList.m
//  Bubble
//
//  Created by wangyunwen on 17/5/16.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "HighScoreList.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Player+CoreDataProperties.h"
#import "scoresViewController.h"


@implementation HighScoreList

@synthesize scoreList_;
@synthesize appDelegate_;

-(HighScoreList*)getData{
    appDelegate_ = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    scoreList_ = [appDelegate_ scoreList];
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.scoreList_.count;
}

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView
{
    return 1; ////return the number of sections
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pp" forIndexPath:indexPath];
    
    Player * player = (Player *)[scoreList_ objectAtIndex: indexPath.row];
    cell.textLabel.text = player.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", player.score];
    
    // Configure the cell to present data...
    //cell.detailTextLabel.text = player.top_score.stringValue;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Player * player = (Player *)[scoreList_ objectAtIndex: indexPath.row];
    NSString *msg =[NSString stringWithFormat:@"name:%@ score:%hd gametime:%d maxbubblenumber:%d", player.name, player.score, player.game_time, player.bubble_number];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"selected player"
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction* action) {}];
    [alert addAction:action];
    
    
    UIViewController *viewController = [self getRootControllerFromTableView:tableView];
    [viewController presentViewController:alert animated:YES completion:nil];
}

-(UIViewController*) getRootControllerFromTableView:(UITableView*)tableview{
    if ([tableview.nextResponder.nextResponder isKindOfClass:UIViewController.class]) {
        return (UIViewController *)tableview.nextResponder.nextResponder;
    } else {
        NSLog(@"%@", tableview.nextResponder.nextResponder.class);
        return nil;
    }
}



@end
