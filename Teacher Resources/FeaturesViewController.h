//
//  FeaturesViewController.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeaturesViewControllerDataSource.h"
#import "RandomizedGroupsViewController.h"
#import "StudentListViewController.h"
#import "ClockViewController.h"
#import "StudentListShufflerViewController.h"
#import "NameFromHatViewController.h"

@interface FeaturesViewController : UIViewController <UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FeaturesViewControllerDataSource *dataSource;
@property (nonatomic, strong) Group *group;

- (void)updateWithGroup:(Group *)group; 

@end
