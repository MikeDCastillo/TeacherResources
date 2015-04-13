//
//  GroupTableViewCell.h
//  Teacher Resources
//
//  Created by Parker Rushton on 4/10/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@protocol AddStudentsDelegate;

@interface GroupTableViewCell : UITableViewCell

@property (strong, nonatomic) Group *group;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleTextLabel;

@property (strong, nonatomic) id<AddStudentsDelegate> delegate;


- (void)updateWithGroup:(Group *)group;

@end

@protocol AddStudentsDelegate <NSObject>

-(void)addStudentsButtonPressed:(id)sender;

@end