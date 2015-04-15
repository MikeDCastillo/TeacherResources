//
//  StudentListShufflerDataSource.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/13/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentListDataSource.h"
#import "GroupViewController.h"

static NSString * const cellIdentifier = @"CellIdentifier";

@interface StudentListDataSource ()

@property (strong, nonatomic) Group *group;


@end

@implementation StudentListDataSource

-(void)registerTableView:(UITableView *)tableView withGroup:(Group *)group{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    self.group = group;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.group.members count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];

    Member *member = self.group.members[indexPath.row];
    cell.textLabel.text = member.name;
    cell.imageView.image = [UIImage imageNamed:@"StudentHat.png"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:20];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        
        Member *member = [self.group.members objectAtIndex:indexPath.row];
        [[GroupController sharedInstance] removeMember:member];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView endUpdates];
    }
}

@end


