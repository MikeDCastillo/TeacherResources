//
//  RandomizedGroupsViewController.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const refreshNotification = @"refresh";

@interface RandomizedGroupsViewController : UIViewController <UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray * usableArray;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) CGFloat screenHeight;
@property (nonatomic,assign) CGFloat screenWidth;
@property (nonatomic, strong) NSIndexPath * arrayIndex;

-(void)refresh;
-(void)refreshData;

@end
