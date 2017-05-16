//
//  scoresViewController.m
//  Bubble
//
//  Created by wangyunwen on 17/5/16.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "scoresViewController.h"
#import "AppDelegate.h"
#import "Player+CoreDataProperties.h"

@interface scoresViewController () {
    NSMutableArray *scoreList_;
    AppDelegate * appDelegate_;
}

@end

@implementation scoresViewController

@synthesize scoreTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate_ = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    scoreList_ = [appDelegate_ scoreList];
    
    self.scoreTableView.delegate = self;
    self.scoreTableView.dataSource = self;
    
    [self.scoreTableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [scoreList_ count];
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
    [self presentViewController:alert animated:YES completion:nil];
}



@end
