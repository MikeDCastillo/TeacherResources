//
//  TimerViewController.m
//  Teacher Resources
//
//  Created by Parker Rushton on 3/10/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"
#import "UIColor+Category.h"

@interface TimerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *startbutton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timer;
@property (weak, nonatomic) IBOutlet UIButton *secButton5;
@property (assign, nonatomic) BOOL fiveSecWarningOn;
@property (weak, nonatomic) IBOutlet UIButton *secondTimer10;
@property (assign, nonatomic) BOOL tenSecWarningOn;
@property (weak, nonatomic) IBOutlet UIButton *secondTimer30;
@property (assign, nonatomic) BOOL thirtySecWarningOn;
@property (weak, nonatomic) IBOutlet UIButton *minTimer1;
@property (assign, nonatomic) BOOL oneMinWarningOn;
@property (weak, nonatomic) IBOutlet UIButton *minTimer2;
@property (assign, nonatomic) BOOL twoMinWarningOn;
@property (weak, nonatomic) IBOutlet UIButton *minTimer5;
@property (assign, nonatomic) BOOL fiveMinWarningOn;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForNotifications];
    [self.picker selectRow:60 *50 inComponent:1 animated:NO];
    [self.picker selectRow:60 *50 inComponent:0 animated:NO];

    //If Timer is OFF
    if ([Timer sharedInstance].isOn == NO) {
        [self.pauseButton setEnabled:NO];
        [self.timer setHidden:YES];
    }
    //If Timer is ON
    else if ([Timer sharedInstance].isOn == YES) {
        [self hidePicker];
    }
    
}

#pragma - mark UIButtons Pressed

- (IBAction)startButtonPressed:(id)sender {
    //When START is pressed
    if ([self.startbutton.titleLabel.text isEqualToString:@"Start"]) {
        [[Timer sharedInstance] startTimer];
        [self updateTimerLabel];
        [self setUpNotification];

        //VIEWS
        //Timer Label
        [self.timer setHidden:NO];
        //Picker
        [self hidePicker];
        
        //Start Button
        [self.startbutton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.startbutton setTitleColor: [UIColor redColor] forState:UIControlStateNormal];
//        [self.startbutton.titleLabel setFont:[UIFont fontWithName:@"Heiti TC" size:42.0]];
        
        //PauseButton
        [self.pauseButton setEnabled:YES];
    }
    //When CANCEL is pressed
    if ([self.startbutton.titleLabel.text isEqualToString:@"Cancel"]) {
        [[Timer sharedInstance] cancelTimer];
    
        //VIEWS
        //Timer Label
        [self.timer setHidden:YES];
        //Picker
        [self showPicker];
        [self.picker selectRow:60 *50 inComponent:1 animated:NO];
        [self.picker selectRow:60 * 50 inComponent:0 animated:NO];

        
        //Start Button
        [self.startbutton setTitle:@"Start" forState:UIControlStateNormal];
        [self.startbutton setTitleColor:[UIColor colorWithRed:0.22 green:0.502 blue:0.141 alpha:1]forState:UIControlStateNormal];
        
        //Pause Button
        [self.pauseButton setEnabled:NO];
        [self.view reloadInputViews];
    }
}

- (IBAction)pauseButtonPressed:(id)sender {
    //When PAUSE is pressed
    if ([self.pauseButton.titleLabel.text isEqualToString:@"Pause"]) {
        [Timer sharedInstance].isOn = NO;
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        [self.pauseButton setTitle:@"Resume" forState:UIControlStateNormal];
        [self.pauseButton setTitleColor:[UIColor colorWithRed:0.22 green:0.502 blue:0.141 alpha:1] forState:UIControlStateNormal];

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

-(void)updateTimerLabel {
    self.timer.text = [NSString stringWithFormat: @"%ld:%02ld", (long)[Timer sharedInstance].minutes, (long)[Timer sharedInstance].seconds];

}

-(void)timerComplete {
    [self.timer setHidden:YES];
    [self showPicker];
}

-(void)hidePicker {
    [self.picker removeFromSuperview];
    [self.secondsLabel setHidden:YES];
    [self.minutesLabel setHidden:YES];
}

-(void)showPicker {
    [self.view addSubview:self.picker];
    [self.secondsLabel setHidden:NO];
    [self.minutesLabel setHidden:NO];
}


- (IBAction)secWarning5:(id)sender {
    if (self.fiveSecWarningOn == NO) {
        self.fiveSecWarningOn = YES;
        [self warningButtonOn:self.secButton5];
    }
    else {
        self.fiveSecWarningOn = NO;
        [self warningButtonOff:self.secButton5];
    }
    
}

- (IBAction)secWarning10:(id)sender {
    if (self.tenSecWarningOn == NO) {
        self.tenSecWarningOn = YES;
        [self warningButtonOn:self.secondTimer10];
    }
    else {
        self.tenSecWarningOn = NO;
        [self warningButtonOff:self.secondTimer10];
    }
}

- (IBAction)secWarning30:(id)sender {
    if (self.thirtySecWarningOn == NO) {
        self.thirtySecWarningOn = YES;
        [self warningButtonOn:self.secondTimer30];
    }
    else {
        self.thirtySecWarningOn = NO;
        [self warningButtonOff:self.secondTimer30];
    }
}

- (IBAction)minWarning1:(id)sender {
    if (self.oneMinWarningOn == NO) {
        self.oneMinWarningOn = YES;
        [self warningButtonOn:self.minTimer1];
    }
    else {
        self.oneMinWarningOn = NO;
        [self warningButtonOff:self.minTimer1];
    }
}

- (IBAction)minWarning2:(id)sender {
    if (self.twoMinWarningOn == NO) {
        self.twoMinWarningOn = YES;
        [self warningButtonOn:self.minTimer2];
    }
    else {
        self.twoMinWarningOn = NO;
        [self warningButtonOff:self.minTimer2];

    }
}

- (IBAction)minWarning5:(id)sender {
    if (self.fiveMinWarningOn == NO) {
        self.fiveMinWarningOn = YES;
        [self warningButtonOn:self.minTimer5];
    }
    else {
        self.fiveMinWarningOn = NO;
        [self warningButtonOff:self.minTimer5];

    }
}

-(void)warningButtonOn:(UIButton *)button {
    button.backgroundColor = [UIColor fern];
    button.tintColor = [UIColor whiteColor];
}

- (void)warningButtonOff:(UIButton *)button {
    button.backgroundColor = [UIColor whiteColor];
    button.tintColor = [UIColor fern];
}

#pragma - mark Notifications & Alerts


- (void)setupAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Time's Up!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self startButtonPressed:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
   
    }

-(void)endTimerAlert {
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Time's Up!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self startButtonPressed:nil];
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
    localNotification.soundName = @"bell_tree.mp3";
    localNotification.alertBody = @"Time's Up!";
    localNotification.applicationIconBadgeNumber = 1;
    
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
}


#pragma - mark Picker Delegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *numberString = [NSString stringWithFormat:@"%@", [self seconds][row]];
    return numberString;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSNumber *minutes = [self seconds][[pickerView selectedRowInComponent:0]];
    [Timer sharedInstance].minutes = [minutes integerValue];
    
    NSNumber *seconds = [self seconds][[pickerView selectedRowInComponent:1]];
    [Timer sharedInstance].seconds = [seconds integerValue];
    
    [self updateTimerLabel];
}

#pragma - mark Picker Data Source

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

@end
