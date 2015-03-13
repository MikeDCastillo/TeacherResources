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

@interface GroupController : NSObject

@property (nonatomic, strong, readonly) NSArray *memberNamesArray;
@property (nonatomic, strong, readonly) NSArray *groupNamesArray;
@property (nonatomic, strong) Group *group;
@property (nonatomic, strong) Member *member;
@property (nonatomic, assign) NSInteger groupSelected;

+ (GroupController *)sharedInstance;

- (void)addMemberWithMemberName:(NSString *)memberName;

- (void)addGroupWithGroupName:(NSString *)groupName;

- (void)removeGroup:(Group *)group;

- (void)removeMember: (Member *)member;

- (void)addMemberToGroup:(Group *)group;

- (void)synchronize;

@end
