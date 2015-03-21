//
//  NameFromHatViewController.m
//  Teacher Resources
//
//  Created by Parker Rushton on 3/17/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "NameFromHatViewController.h"
#import "UIColor+Category.h"
#include <stdlib.h>
#include <math.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}

static CGFloat const ticketWidth = 300.0;
static CGFloat const ticketHeight = 150.0;

@interface NameFromHatViewController ()

@property (strong, nonatomic) UIButton *drawingButton;
@property (strong, nonatomic) UILabel *winnerLabel;

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
    
}

- (void)newWinnerButtonPressed {
    
    self.winnerLabel.text = @"?????";
    [self growsOnTouch:self.winnerLabel withDuration:2];
    [self.drawingButton setEnabled:NO];
    [self.drawingButton setTitle:@"Drumroll!!" forState:UIControlStateDisabled];
    [self.drawingButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [self performSelector:@selector(updateWinnerLabel) withObject:nil afterDelay:2];

}

- (void)updateWinnerLabel {
    
    NSArray *array = [GroupController sharedInstance].temporaryStudentList;
    if ( array.count == 0) {
        self.winnerLabel.text = @"There aren't any students in this class!";
    }
    else {
        array = [[GroupController sharedInstance] shuffle:array];
        Member *member = array[0];
        
        self.winnerLabel.text = member.name;
    }
    [self.drawingButton setEnabled:YES];
}

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
    
    self.winnerLabel = [[UILabel alloc] initWithFrame: CGRectMake(25, screenHeight/2 - (ticketHeight), ticketWidth, ticketHeight)];
    
    self.winnerLabel.font = [UIFont fontWithName:@"Chalkduster" size:60];
    self.winnerLabel.textColor = [UIColor whiteColor];
    self.winnerLabel.textAlignment = NSTextAlignmentCenter;
    self.winnerLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.winnerLabel];
}

#pragma mark - Animations

- (void)growsOnTouch:(UIView *)view withDuration:(float)duration {
    
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
