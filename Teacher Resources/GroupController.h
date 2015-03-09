//
//  GroupController.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group.h"
#import "Stack.h"

@interface GroupController : NSObject

@property (nonatomic, strong, readonly) NSArray *studentNamesArray;
@property (nonatomic, strong, readonly) NSArray *groupNamesArray;

+ (GroupController *)sharedInstance;

- (void)addGroupWithGroupName:(NSString *)groupName studentName:(NSString *)studentName;

- (void)removeGroup:(Group *)group;

- (void)synchronize;

@end
