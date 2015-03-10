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

//- (NSArray *)studentNamesArray {
//    
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
//    
//    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
//    
//    return objects;
//    
//}

- (NSArray *)groupNamesArray {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
    
}

- (void)addGroupWithGroupName:(NSString *)groupName {
    
    Group *group = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    group.title = groupName;
    [self synchronize];
    
    
}

-(void)addMemberToGroup:(Group *)group {
    
}

- (void)removeGroup:(Group *)group {
    
    [group.managedObjectContext deleteObject:group];
    [self synchronize];
}

-(void)removeMember:(Member *)member {
    [member.managedObjectContext deleteObject:member];
    [self synchronize];
}

- (void)synchronize {
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
    
}

@end


