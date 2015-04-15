//
//  GroupTableViewDataSource.m
//  Teacher Resources
//
//  Created by Parker Rushton on 4/10/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "GroupTableViewDataSource.h"
#import "GroupController.h"
#import "Group.h"

static NSString *cellID = @"cellID";

@implementation GroupTableViewDataSource

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView = tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [GroupController sharedInstance].groups.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Group *currentGroup = [GroupController sharedInstance].groups[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = currentGroup.title;
    cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:34];
    cell.textLabel.textColor = [UIColor whiteColor];

    cell.detailTextLabel.font = [UIFont fontWithName:@"Chalkduster" size:14];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    NSInteger classSize = currentGroup.members.count;
    NSString *numberOfStudents = [NSString stringWithFormat:@"%ld Students",(long)classSize];
    if (classSize == 0) {
        cell.detailTextLabel.text = @"empty";
    }
    else {
        cell.detailTextLabel.text = numberOfStudents;
    }
    
    
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[GroupController sharedInstance] removeGroup:[[GroupController sharedInstance].groups objectAtIndex:indexPath.row]];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

@end
