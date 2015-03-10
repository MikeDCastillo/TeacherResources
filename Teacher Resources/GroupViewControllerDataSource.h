//
//  GroupViewControllerDataSource.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupController.h"
@import UIKit;

@interface GroupViewControllerDataSource : NSObject <UITableViewDataSource>

-(void)registerTableView:(UITableView *)tableView;

@end
