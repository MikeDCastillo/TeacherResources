//
//  PageViewController.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/20/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerOne.h"
#import "ViewControllerTwo.h"
#import "ViewControllerThree.h"
#import "ViewControllerFour.h"
#import "ViewControllerFive.h"
#import "ViewControllerSix.h"

@interface PageViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) ViewControllerOne *vcOne;
@property (nonatomic, strong) ViewControllerTwo *vcTwo;
@property (nonatomic, strong) ViewControllerThree *vcThree;
@property (nonatomic, strong) ViewControllerFour *vcFour;
@property (nonatomic, strong) ViewControllerFive *vcFive;
@property (nonatomic, strong) ViewControllerSix *vcSix;


@end
