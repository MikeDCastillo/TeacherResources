//
//  MembersCollectionViewCell.m
//  Teacher Resources
//
//  Created by Christian Monson on 3/10/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "MembersCollectionViewCell.h"

@implementation MembersCollectionViewCell

- (void)configureCellWithName:(NSString *)name {
    self.textLabel.text = name;
}

@end
