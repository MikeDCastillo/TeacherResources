//
//  TimerViewController.m
//  Teacher Tools
//
//  Created by Parker Rushton on 3/10/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"
#import "UIColor+Category.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface TimerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic)  UIPickerView *picker;
@property (strong, nonatomic)  UIButton *startbutton;
@property (strong, nonatomic)  UIButton *pauseButton;
@property (strong, nonatomic)  UILabel *secondsLabel;
@property (strong, nonatomic)  UILabel *minutesLabel;
@property (strong, nonatomic)  UILabel *timerLabel;


@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForNotifications];
    [self setupViews];
    self.view.backgroundColor = [UIColor chalkboardGreen];
    self.title = @"Timer";
    
    //Makes Picker appear Circular
    [self.picker selectRow:60 * 50 inComponent:1 animated:NO];
    [self.picker selectRow:60 * 50 inComponent:0 animated:NO];
    
    //If Timer is OFF
    if ([Timer sharedInstance].isOn == NO) {
        [self.pauseButton setEnabled:NO];
        [self.timerLabel setHidden:YES];
        [self.startbutton setTitle:@"Start" forState:UIControlStateNormal];
        
    }
    //If Timer is ON
    else if ([Timer sharedInstance].isOn == YES) {
        [self hidePicker];
        [self.timerLabel setHidden:NO];
        [self.pauseButton setEnabled:YES];
        [self.startbutton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.startbutton setTitleColor: [UIColor redColor] forState:UIControlStateNormal];
    }
    
}

#pragma mark - Setup Views

-(void)setupViews {
    //Picker View
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(30, 90, self.view.frame.size.width - 80, 150)];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    [self.view addSubview:self.picker];
    
    //Minutes Label
    self.minutesLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 155, 80, 30)];
    self.minutesLabel.textColor = [UIColor whiteColor];
    self.minutesLabel.text = @"min";
    self.minutesLabel.font = [UIFont fontWithName:@"Chalkduster" size:14];
    [self.view addSubview:self.minutesLabel];
    
    //Seconds Label
    self.secondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 155, 80, 30)];
    self.secondsLabel.textColor = [UIColor whiteColor];
    self.secondsLabel.text = @"sec";
    self.secondsLabel.font = [UIFont fontWithName:@"Chalkduster" size:14];
    [self.view addSubview:self.secondsLabel];
    
    //Timer label
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height/4)];
    self.timerLabel.text = @"";
    self.timerLabel.font = [UIFont fontWithName:@"Chalkduster" size:100];
    self.timerLabel.textColor = [UIColor whiteColor];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.timerLabel];

    //Start Button
    self.startbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startbutton.frame = CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, 80);
    self.startbutton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:60];
    self.startbutton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.startbutton.titleLabel.textColor = [UIColor whiteColor];
    [self.startbutton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startbutton];
    
    //Pause Button
    self.pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pauseButton.frame = CGRectMake(0, self.view.frame.size.height/2 + 100, self.view.frame.size.width, 80);
    [self.pauseButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    self.pauseButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:50];
    self.pauseButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.pauseButton.titleLabel.textColor = [UIColor whiteColor];
    [self.pauseButton addTarget:self action:@selector(pauseButtonPressed) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.pauseButton];
}

//Hide and Show Picker

-(void)hidePicker {
    [self.picker setHidden:YES];
    [self.secondsLabel removeFromSuperview];
    [self.minutesLabel setHidden:YES];
    [self.timerLabel setHidden:NO];
}

-(void)showPicker {
    [self.picker setHidden:NO];
    [self.view addSubview:self.secondsLabel];
    [self.minutesLabel setHidden:NO];
    [self.timerLabel setHidden:YES];
}

#pragma mark - UIButtons Pressed

- (void)startButtonPressed {
    //When START is pressed
    if ([self.startbutton.titleLabel.text isEqualToString:@"Start"]) {
        [[Timer sharedInstance] startTimer];
        [self updateTimerLabel];
        [self setUpNotification];
        
        [self hidePicker];
        
        //Start Button
        [self.startbutton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.startbutton setTitleColor: [UIColor redColor] forState:UIControlStateNormal];
        
        //PauseButton
        [self.pauseButton setEnabled:YES];
    }
    //When CANCEL is pressed
    else if ([self.startbutton.titleLabel.text isEqualToString:@"Cancel"]) {
        [[Timer sharedInstance] cancelTimer];
        
        [self showPicker];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];

        [self.picker selectRow:60 * 50 inComponent:0 animated: NO];
        [self.picker selectRow:60 * 50 inComponent:1 animated: NO];
        
        [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.pauseButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        //Start Button
        [self.startbutton setTitle:@"Start" forState:UIControlStateNormal];
        [self.startbutton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        
        //Pause Button
        [self.pauseButton setEnabled:NO];
        [self.view reloadInputViews];
    }
}

- (void)pauseButtonPressed {
    //When PAUSE is pressed
    if ([self.pauseButton.titleLabel.text isEqualToString:@"Pause"]) {
        [[Timer sharedInstance]pauseTimer];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [self.pauseButton setEnabled:NO];
        [self performSelector:@selector(setPauseButtonToResume) withObject:nil afterDelay:.33333];
    }
    //When RESUME is pressed
    if ([self.pauseButton.titleLabel.text isEqualToString:@"Resume"]) {
        [[Timer sharedInstance] startTimer];
        [self setUpNotification];
        
        //Add Edit Views
        [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.pauseButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
}

- (void)setPauseButtonToResume {
    [self.pauseButton setEnabled:YES];
    [self.pauseButton setTitle:@"Resume" forState:UIControlStateNormal];
    [self.pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark - Timer Methods

-(void)updateTimerLabel {
    self.timerLabel.text = [NSString stringWithFormat: @"%ld:%02ld", (long)[Timer sharedInstance].minutes, (long)[Timer sharedInstance].seconds];
}

-(void)timerComplete {
    [self.timerLabel setHidden:YES];
    [self showPicker];
}

#pragma mark - Notifications & Alerts


- (void)setupAlert {
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:@"Tock" ofType:@"aiff"]] error:NULL];
    [audioPlayer play];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Time's Up!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self startButtonPressed];
        [audioPlayer stop];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)endTimerAlert {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Time's Up!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self startButtonPressed ];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimerLabel) name:secondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endTimerAlert) name:timerCompleteNotification object:nil];
}

- (void)setUpNotification{
    UILocalNotification *localNotification = [UILocalNotification new];
    NSDate *fireDate = [[NSDate date]dateByAddingTimeInterval: ([Timer sharedInstance].minutes * 60) + [Timer sharedInstance].seconds];
    localNotification.fireDate = fireDate;
    
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.soundName = @"bell_three.mp3";
    localNotification.alertBody = @"Time's Up!";
    localNotification.applicationIconBadgeNumber = 1;
    
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
}

#pragma mark - Picker Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self seconds] count];
}

-(NSArray *)seconds {
    NSMutableArray *secondsMutable = [[NSMutableArray alloc] init];
    NSArray *secondsArray = [[NSArray alloc] init];
    for (int i = 0; i < 100; i++) {
        
        for (int i = 0; i < 60; i ++) {
            [secondsMutable addObject:[NSNumber numberWithInt:i]];
        }
    }
    secondsArray = secondsMutable;
    return secondsArray;
}

#pragma mark - Picker Delegate

-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *numberString = [NSString stringWithFormat:@"%@", [self seconds][row]];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:numberString attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSNumber *minutes = [self seconds][[pickerView selectedRowInComponent:0]];
    [Timer sharedInstance].minutes = [minutes integerValue];
    
    NSNumber *seconds = [self seconds][[pickerView selectedRowInComponent:1]];
    [Timer sharedInstance].seconds = [seconds integerValue];
    
    [self updateTimerLabel];
}

@end
