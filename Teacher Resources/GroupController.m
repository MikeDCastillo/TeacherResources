//
//  GroupController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "GroupController.h"

@implementation GroupController

+ (GroupController *)sharedInstance {
    static GroupController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [GroupController new];
    });
    
    return sharedInstance;
    
}

- (NSArray *)studentNames {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
    
}

- (NSArray *)groupNames {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
    
}

- (void)addGroupWithGroupName:(NSString *)groupName studentName:(NSString *)studentName {
    
    Group *group = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    group.groupName = groupName;
    group.studentName = studentName;
    
    [self synchronize];
    
    
}

- (void)removeGroup:(Group *)group {
    
    [group.managedObjectContext deleteObject:group];
    [self synchronize];
    
    
}

- (void)synchronize {
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
    
}

@end


