//
//  GroupDetailViewControllerDataSource.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/7/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentListDataSource.h" 
#import "GroupViewController.h"
#import "Member.h"

static NSString * const cellIdentifier = @"CellIdentifier";

@interface StudentListDataSource()

@property (strong, nonatomic) Group *group;
@property (strong, nonatomic) NSArray *members;

@end

@implementation StudentListDataSource

-(void)registerTableView:(UITableView *)tableView withGroup:(Group *)group {
    
     [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
    self.group = group;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.group.members.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];    
    Member *member = [self.group.members objectAtIndex:indexPath.row];
    cell.textLabel.text = member.name;
    
    cell.imageView.image = [UIImage imageNamed:@"StudentHat.png"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        
        [[GroupController sharedInstance] removeMember: self.group.members[indexPath.row]];
         
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView endUpdates];
    }
}



@end
