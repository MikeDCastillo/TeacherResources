//
//  RandomizedGroupsViewController.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

static NSString * const refreshNotification = @"refresh";
static int numberOfPeopleInGroup = 2;

@interface RandomizedGroupsViewController : UIViewController <UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray * usableArray;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) CGFloat screenHeight;
@property (nonatomic,assign) CGFloat screenWidth;
@property (nonatomic,strong) NSIndexPath * arrayIndex;
@property (nonatomic,strong) Group *group;

-(void)refresh;
-(void)refreshData;
-(void)updateWithGroup:(Group *)group;

@end
