//
//  GroupDetailViewControllerDataSource.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/7/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface GroupDetailViewControllerDataSource : NSObject <UITableViewDataSource>

-(void)registerTableView:(UITableView *)tableView;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
