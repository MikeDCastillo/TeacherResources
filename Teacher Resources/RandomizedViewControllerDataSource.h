//
//  RandomizedViewControllerDataSource.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Group.h"

static NSString *cellIdentifier = @"cell";

@interface RandomizedViewControllerDataSource : NSObject <UICollectionViewDataSource>

-(void)registerCollectionView:(UICollectionView *)collectionView withGroup:(Group *)group;

@property (nonatomic,strong) NSIndexPath *arrayIndex;

@end