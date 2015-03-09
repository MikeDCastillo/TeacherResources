//
//  GroupDetailViewControllerDataSource.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/7/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentListDataSource.h"

static NSString * const cellIdentifier = @"CellIdentifier";

@implementation StudentListDataSource

-(void)registerTableView:(UITableView *)tableView {
    
     [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.textLabel.text = @" Student name ";
    
    return cell;
    
}

@end
