//
//  Group.h
//  Teacher Resources
//
//  Created by Parker Rushton on 3/9/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Member;

@interface Group : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSOrderedSet *members;
@end

@interface Group (CoreDataGeneratedAccessors)

- (void)insertObject:(Member *)value inMembersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMembersAtIndex:(NSUInteger)idx;
- (void)insertMembers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMembersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMembersAtIndex:(NSUInteger)idx withObject:(Member *)value;
- (void)replaceMembersAtIndexes:(NSIndexSet *)indexes withMembers:(NSArray *)values;
- (void)addMembersObject:(Member *)value;
- (void)removeMembersObject:(Member *)value;
- (void)addMembers:(NSOrderedSet *)values;
- (void)removeMembers:(NSOrderedSet *)values;
@end
