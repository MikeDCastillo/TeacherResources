//
//  StudentListShufflerViewController.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/13/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentListShufflerDataSource.h"
#import "GroupViewController.h"
#import "GroupController.h"
#import "Group.h"
#import "UIColor+Category.h"

@interface StudentListShufflerViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) StudentListDataSource *datasource;
@property (nonatomic, strong) Group *group;
@property (nonatomic, assign) NSInteger *groupNameIndex;
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) NSIndexPath *index;

- (void)updateWithGroup:(Group *)group;

@end