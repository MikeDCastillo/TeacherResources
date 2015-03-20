//
//  PageViewController.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/20/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewDataSource.h"

@interface PageViewController : UIViewController

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) PageViewDataSource *dataSource;


@end
