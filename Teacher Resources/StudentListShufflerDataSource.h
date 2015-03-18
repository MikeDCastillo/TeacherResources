//
//  StudentListShufflerDataSource.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/13/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupController.h"
#import "Member.h"
@import UIKit;

@interface StudentListShufflerDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray *members;

-(void)registerTableView:(UITableView *)tableView withGroup:(Group *)group;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
