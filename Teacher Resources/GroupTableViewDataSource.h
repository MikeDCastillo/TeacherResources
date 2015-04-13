//
//  GroupTableViewDataSource.h
//  Teacher Resources
//
//  Created by Parker Rushton on 4/10/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GroupTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

- (void)registerTableView:(UITableView *)tableView;

@end
