//
//  MembersCollectionViewCell.m
//  Teacher Resources
//
//  Created by Christian Monson on 3/10/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "MembersCollectionViewCell.h"
#import "UIColor+Category.h"

@implementation MembersCollectionViewCell

@synthesize name;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupViews];
    }
    return self;
}

-(void)setupViews
{
    self.backgroundColor = [UIColor clearColor];
    [self.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.layer setBorderWidth:2.0];
    [self.layer setCornerRadius:10];
    [self.layer setShadowOffset:CGSizeMake(1, 5)];
    [self.layer setShadowColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5].CGColor];
    
    self.labelFrame = self.bounds;
    name = [[UILabel alloc]initWithFrame:self.labelFrame];
    [name setTextAlignment:NSTextAlignmentCenter];
    [name setTextColor:[UIColor whiteColor]];
<<<<<<< Updated upstream
    [name setFont:[UIFont fontWithName:@"Chalkduster" size:20]];
=======
    [name setFont:[UIFont fontWithName:@"Chalkboard" size:20]];
>>>>>>> Stashed changes
    [self addSubview:name];
}

-(void)updateLabelFrame:(CGRect)frame
{
    [name setFrame:frame];
    [name setNeedsLayout];
}

@end