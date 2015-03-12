//
//  GroupDetailViewControllerDataSource.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/7/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentListDataSource.h"
#import "GroupViewController.h"

static NSString * const cellIdentifier = @"CellIdentifier";

@implementation StudentListDataSource

-(void)registerTableView:(UITableView *)tableView {
    
     [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [GroupController sharedInstance].memberNamesArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    Member *member = [GroupController sharedInstance].memberNamesArray[indexPath.row];
    cell.textLabel.text = member.name;
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        
        [[GroupController sharedInstance] removeMember:[[GroupController sharedInstance].memberNamesArray objectAtIndex:indexPath.row]];
         
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView endUpdates];
    }
}



@end
