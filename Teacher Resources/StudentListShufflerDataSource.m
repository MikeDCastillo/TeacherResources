//
//  StudentListShufflerDataSource.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/13/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentListShufflerDataSource.h"
#import "GroupViewController.h"

static NSString * const cellIdentifier = @"CellIdentifier";

@interface StudentListShufflerDataSource ()

@property (strong, nonatomic) Group *group;


@end

@implementation StudentListShufflerDataSource

-(void)registerTableView:(UITableView *)tableView withGroup:(Group *)group{
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
    self.group = group;
    self.members = [group.members array];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.group.members.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    Member *member = self.members[indexPath.row];
    
    cell.textLabel.text = member.name;
    
    cell.imageView.image = [UIImage imageNamed:@"StudentHat.png"];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        
        [[GroupController sharedInstance] removeMember: self.members[indexPath.row]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView endUpdates];
    }
}

@end
