//
//  GroupDetailViewController.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentListDataSource.h"
#import "GroupViewController.h"
#import "GroupController.h"
#import "Group.h"
#import "UIColor+Category.h"

@interface StudentListViewController : UIViewController

@property (nonatomic, strong) UIButton *addGroupButton;
@property (nonatomic, strong) UIButton *addStudentButton;
@property (nonatomic, strong) UIButton *clearButton; 
@property (nonatomic, strong) UITextField *groupNameTextField;
@property (nonatomic, strong) UITextField *studentNameTextField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) StudentListDataSource *dataSource;
@property (nonatomic, strong) Group *group;
@property (nonatomic, assign) NSInteger *groupNameIndex;

- (void)updateWithGroup:(Group *)group;

@end
