//
//  GroupController.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group.h"
#import "Member.h"
#import "Stack.h"

static NSString * const studentKey = @"studentKey";

@interface GroupController : NSObject

@property (nonatomic, strong, readonly) NSArray *groups;
@property (nonatomic, strong) Group *group;
@property (nonatomic, strong) Member *member;

+ (GroupController *)sharedInstance;


- (void)addMemberWithMemberName:(NSString *)memberName toGroup:(Group *)group; 

- (void)addGroupWithGroupName:(NSString *)groupName;

- (void)removeGroup:(Group *)group;

- (void)removeMember: (Member *)member;

- (void)shuffle:(NSArray *)array;

- (void)synchronize;

@end
