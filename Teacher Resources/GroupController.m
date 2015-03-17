//
//  GroupController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "GroupController.h"

static Group *currentGroup;

@implementation GroupController

+ (GroupController *)sharedInstance {
    static GroupController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [GroupController new];
    });
    
    return sharedInstance;
    
}

- (NSArray *)groups {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
    
}

- (void)addGroupWithGroupName:(NSString *)groupName {
    
    Group *group = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    group.title = groupName;
    [self synchronize];
    
    
}

- (void)addMemberWithMemberName:(NSString *)memberName toGroup:(Group *)group {
    
    Member *member = [NSEntityDescription insertNewObjectForEntityForName:@"Member" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    member.group = group;
    
    member.name = memberName;
    [self synchronize];
    
}


- (void)removeGroup:(Group *)group {
    
    [group.managedObjectContext deleteObject:group];
    [self synchronize];
}

-(void)removeMember:(Member *)member {
    [member.managedObjectContext deleteObject:member];
    [self synchronize];
}

- (NSArray *)shuffle:(NSArray *)array
{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:array];
    
    NSUInteger count = [newArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [newArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return newArray;
}

- (void)synchronize {
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
    
}

@end


