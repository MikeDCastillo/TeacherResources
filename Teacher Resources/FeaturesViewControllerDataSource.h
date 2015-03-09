//
//  FeaturesViewControllerDataSource.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface FeaturesViewControllerDataSource : NSObject <UICollectionViewDataSource>

- (NSArray *)iconImageNames;

- (void)registerCollectionView:(UICollectionView *)collectionView;

@end
