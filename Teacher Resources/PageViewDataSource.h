//
//  PageViewDataSource.h
//  Teacher Resources
//
//  Created by Ethan Hess on 3/20/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageViewContentController.h"
#import <UIKit/UIKit.h>

@interface PageViewDataSource : NSObject <UIPageViewControllerDataSource>


- (UIViewController *)viewControllerAtIndex:(NSInteger)index;

@end
