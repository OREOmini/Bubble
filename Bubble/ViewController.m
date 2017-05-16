//
//  ViewController.m
//  Bubble
//
//  Created by wangyunwen on 17/5/7.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import "ViewController.h"
#import "BubbleViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize nameField;
@synthesize startBtn;
@synthesize bubbleNumberLabel;
@synthesize gameTimeSlider;
@synthesize bubbleNumberSlider;
@synthesize gameTimeLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer * tapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handleBackgroundTap:)];
    tapRecogniser.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecogniser];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"start_game"]) {
    BubbleViewController *des = segue.destinationViewController;
    des.userName = nameField.text;
    des.gameTime = [NSString stringWithFormat:@"%d", (int)gameTimeSlider.value];
    des.bubbleNumber = [NSNumber numberWithInt:(int)bubbleNumberSlider.value];
    }
}


- (IBAction)startGame:(id)sender {
    [self onDismissKeyboard:sender];
    
//    NSString *username = nameField.text;
//    if(username.length == 0) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please enter username"
//                                                                       message:@"Please enter username"
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
//                                                         style:UIAlertActionStyleDefault
//                                                       handler:^(UIAlertAction* action) {}];
//        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:nil];
//       
//    } else {
//        [self performSegueWithIdentifier:@"start_game" sender:nil];
//    }
    [self performSegueWithIdentifier:@"start_game" sender:nil];
}
- (IBAction)gameTimeSliderChange:(id)sender {
    gameTimeLabel.text = [NSString stringWithFormat:@"%d", (int)gameTimeSlider.value];
}

- (IBAction)bubbleNumberSliderChange:(id)sender {
    bubbleNumberLabel.text = [NSString stringWithFormat:@"%d", (int)bubbleNumberSlider.value];
}

- (IBAction)onDismissKeyboard:(id)sender {
    [nameField resignFirstResponder];
}

- (void)handleBackgroundTap:(UITapGestureRecognizer*) sender {
    [self onDismissKeyboard:sender];
}
@end
