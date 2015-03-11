//
//  StudentController.h
//  Teacher Resources
//
//  Created by Christian Monson on 3/11/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const studentKey = @"studentKey";

@interface StudentController : NSObject

@property (nonatomic,strong) NSArray * students;

+(StudentController *)SharedInstance;

-(void)removeStudent:(NSInteger)index;

-(void)addStudent:(NSString *)student;

-(void)shuffle:(NSArray *)array;

@end