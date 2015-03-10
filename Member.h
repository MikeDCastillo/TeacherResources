//
//  Member.h
//  Teacher Resources
//
//  Created by Parker Rushton on 3/9/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Group;

@interface Member : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Group *group;

@end
