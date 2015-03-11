//
//  RandomizedViewControllerDataSource.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *cellIdentifier = @"cell";

@interface RandomizedViewControllerDataSource : NSObject <UICollectionViewDataSource>

-(void)registerCollectionView:(UICollectionView *)collectionView;

@property (nonatomic,strong) NSIndexPath *arrayIndex;

@end