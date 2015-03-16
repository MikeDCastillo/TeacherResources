//
//  StudentController.m
//  Teacher Resources
//
//  Created by Christian Monson on 3/11/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentController.h"
#import "GroupController.h"

@implementation StudentController

+(StudentController *)SharedInstance
{
    static StudentController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[StudentController alloc] init];
        sharedInstance.students = [[NSArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:studentKey]];
    });
    
    return sharedInstance;
}

-(void)addStudent:(NSString *)student
{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:[StudentController SharedInstance].students];
    [newArray addObject:student];
    [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:studentKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.students = newArray;
}

-(void)removeStudent:(NSInteger)index
{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:[StudentController SharedInstance].students];
    [newArray removeObjectAtIndex:index];
    [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:studentKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.students = newArray;
}

- (void)shuffle:(NSArray *)array
{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:array];
    
    NSUInteger count = [newArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [newArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    [StudentController SharedInstance].students = newArray;
//    [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:studentKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


@end