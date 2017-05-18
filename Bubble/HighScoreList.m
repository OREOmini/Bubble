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

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation HighScoreList

@synthesize scoreList_;
@synthesize appDelegate_;

-(HighScoreList*)getData{
    appDelegate_ = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    scoreList_ = [appDelegate_ scoreList];
    return self;
}

// give the tableView a border
-(void)setTableViewstyle:(UITableView*)tableView {
    tableView.layer.borderWidth = 10;
    tableView.layer.borderColor = UIColorFromRGB(0xBBB9BE).CGColor;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self setTableViewstyle:tableView];
    if(self.scoreList_.count <= 10)
        return self.scoreList_.count;
    else
        return 10;
}

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView
{
    return 1; ////return the number of sections
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pp" forIndexPath:indexPath];
    
    Player * player = (Player *)[scoreList_ objectAtIndex: indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"NO.%ld   %@", indexPath.row+1, player.name];    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", player.score];
    
   
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Player * player = (Player *)[scoreList_ objectAtIndex: indexPath.row];
    NSString *msg =[NSString stringWithFormat:@"name:%@\n score:%hd\n gametime:%d\n maxbubblenumber:%d", player.name, player.score, player.game_time, player.bubble_number];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Selected Player"
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction* action) {}];
    [alert addAction:action];
    
    
    UIViewController *viewController = [self getRootControllerFromTableView:tableView];
    [viewController presentViewController:alert animated:YES completion:nil];
}

// get the root viewController of current tableView in order to show the detail alert
-(UIViewController*) getRootControllerFromTableView:(UITableView*)tableview{
    if ([tableview.nextResponder.nextResponder isKindOfClass:UIViewController.class]) {
        return (UIViewController *)tableview.nextResponder.nextResponder;
    } else {
        NSLog(@"%@", tableview.nextResponder.nextResponder.class);
        return nil;
    }
}



@end
