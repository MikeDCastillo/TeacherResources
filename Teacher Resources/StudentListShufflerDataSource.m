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

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[GroupController sharedInstance].temporaryStudentList count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    Member *member = [GroupController sharedInstance].temporaryStudentList[indexPath.row];
    
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
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:[GroupController sharedInstance].temporaryStudentList];
        [mutableArray removeObjectAtIndex:indexPath.row];
        [GroupController sharedInstance].temporaryStudentList = mutableArray;
    
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView endUpdates];
    }
}

@end


