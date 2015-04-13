//
//  GroupTableViewCell.m
//  Teacher Resources
//
//  Created by Parker Rushton on 4/10/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "GroupTableViewCell.h"

@implementation GroupTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (self.group) {
            [self awakeFromNib];
        }
    }
    return self;
}

-(void)updateWithGroup:(Group *)group {
    self.group = group;
}

- (IBAction)plusButtonPressed:(id)sender {
    sender = self;
    [self.delegate addStudentsButtonPressed:self];
    NSLog(@"sender: %@", sender);
}

- (void)awakeFromNib {    
    
    
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.backgroundColor = [UIColor clearColor];
    self.nameLabel.text = self.group.title;

    NSInteger classSize = self.group.members.count;
    NSString *numberOfStudents = [NSString stringWithFormat:@"%ld Students",(long)classSize];
    if (classSize == 0) {
        self.subtitleTextLabel.text = @"empty";
    }
    else {
        self.subtitleTextLabel.text = numberOfStudents;
    }

}
@end
