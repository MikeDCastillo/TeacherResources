//
//  GroupTableViewDataSource.m
//  Teacher Resources
//
//  Created by Parker Rushton on 4/10/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "GroupTableViewDataSource.h"
#import "GroupController.h"
#import "GroupTableViewCell.h"
#import "Group.h"

@implementation GroupTableViewDataSource

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[GroupTableViewCell class] forCellReuseIdentifier:@"cellID"];

    self.tableView = tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [GroupController sharedInstance].groups.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    Group *currentGroup = [GroupController sharedInstance].groups[indexPath.row];
    
    GroupTableViewCell *cell = (GroupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"groupCellID" owner:self options:nil];
        cell = (GroupTableViewCell *)[nib objectAtIndex:0];
        cell = [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        [cell updateWithGroup:currentGroup];
    }
    
    [cell updateWithGroup:currentGroup];
    
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
