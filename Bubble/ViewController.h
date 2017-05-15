//
//  ViewController.h
//  Bubble
//
//  Created by wangyunwen on 17/5/7.
//  Copyright © 2017年 wangyunwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
- (IBAction)startGame:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *gameTimeSlider;
@property (weak, nonatomic) IBOutlet UISlider *bubbleNumberSlider;
@property (weak, nonatomic) IBOutlet UILabel *gameTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bubbleNumberLabel;


- (IBAction)gameTimeSliderChange:(id)sender;
- (IBAction)bubbleNumberSliderChange:(id)sender;
- (IBAction)onDismissKeyboard:(id)sender;

- (void)handleBackgroundTap:(UITapGestureRecognizer*) sender;


@end

