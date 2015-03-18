//
//  NameFromHatViewController.h
//  Teacher Resources
//
//  Created by Parker Rushton on 3/17/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "GroupController.h"

@interface NameFromHatViewController : UIViewController

@property (nonatomic, strong) Group *group;

- (void)updateWithGroup:(Group *)group;

@end
