//
//  NameFromHatViewController.m
//  Teacher Resources
//
//  Created by Parker Rushton on 3/17/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "NameFromHatViewController.h"
#import "UIColor+Category.h"
#import <AVFoundation/AVFoundation.h>
#include <stdlib.h>
#include <math.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}

//static CGFloat const ticketWidth = 300.0;
static CGFloat const ticketHeight = 150.0;

@interface NameFromHatViewController ()

@property (strong, nonatomic) UIButton *drawingButton;
@property (strong, nonatomic) UILabel *winnerLabel;
@property (strong, nonatomic) NSMutableArray *hatArray;
@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation NameFromHatViewController

-(void)updateWithGroup:(Group *)group {
    self.group = group;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.group.title;
    self.view.backgroundColor = [UIColor chalkboardGreen];
    [self setupDrawingButton];
    [self setupWinnerLabel];
    [self.player prepareToPlay];
    
    if (!self.hatArray) {
        self.hatArray = [NSMutableArray arrayWithArray:[GroupController sharedInstance].temporaryStudentList];
    }
}

#pragma mark - UIView Elements

- (void)setupDrawingButton {
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    
    self.drawingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.drawingButton.frame = CGRectMake(25, screenHeight - 150, screenWidth - 50, 75);
    [self.drawingButton setTitle:@"Draw Name!" forState:UIControlStateNormal];
    [self.drawingButton.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:34]];
    [self.drawingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.drawingButton addTarget:self action:@selector(newWinnerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.drawingButton];
    
}

- (void)setupWinnerLabel {
    CGFloat screenHeight = self.view.frame.size.height;
    
    self.winnerLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, screenHeight/2 - (ticketHeight), self.view.frame.size.width, ticketHeight)];
    
    self.winnerLabel.font = [UIFont fontWithName:@"Chalkduster" size:60];
    self.winnerLabel.textColor = [UIColor whiteColor];
    self.winnerLabel.textAlignment = NSTextAlignmentCenter;
    self.winnerLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.winnerLabel];
}

#pragma mark - Names Array methods

-(void)resetHatArray {
    self.hatArray = [NSMutableArray arrayWithArray:[GroupController sharedInstance].temporaryStudentList];
}

-(void)newWinnerButtonPressed {
    if (self.hatArray.count == 0 && [self.drawingButton.titleLabel.text isEqualToString:@"Draw Name!"]) {
        self.winnerLabel.text = @"All the students have been drawn!";
        [self.drawingButton setTitle:@"Reset Names" forState:UIControlStateNormal];
        [self resetHatArray];
    } else {
    
    if ([self.drawingButton.titleLabel.text isEqualToString:@"Reset Names"]) {
        [self.drawingButton setTitle: @"Draw Name!" forState:UIControlStateNormal];
    } else {
        self.winnerLabel.text = @"?????";
        [self growsOnTouch:self.winnerLabel withDuration:1.6];
        [self.drawingButton setEnabled:NO];
        [self.drawingButton setTitle:@"Drumroll!!" forState:UIControlStateDisabled];
        [self.drawingButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        
        NSURL *timerSound = [[NSBundle mainBundle] URLForResource:@"drumroll" withExtension:@"mp3"];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:timerSound error:nil];
        [self.player play];

        [self performSelector:@selector(updateWinnerLabel) withObject:nil afterDelay:1.6];
        }
    }
}

-(void)updateWinnerLabel {
    NSMutableArray *array = self.hatArray;
    if (array.count == 0) {

    } else {
        array = [NSMutableArray arrayWithArray:[[GroupController sharedInstance] shuffle:array]];
        Member *member = array[0];
        self.winnerLabel.text = member.name;
        [array removeObject:member];
        self.hatArray = array;
    }
    [self.drawingButton setEnabled:YES];
}

#pragma mark - Animations

-(void)growsOnTouch:(UIView *)view withDuration:(float)duration {
    
    CGAffineTransform bigger = CGAffineTransformMakeScale(10, 10);
    CGAffineTransform smaller = CGAffineTransformMakeScale(1, 1);
    CGAffineTransform rotate = CGAffineTransformMakeRotation(radians(180));
    [UIView animateWithDuration:duration animations:^{
        view.transform = bigger;
        view.transform = rotate;
        view.transform = smaller;
    }];
}

@end
