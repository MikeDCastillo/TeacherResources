//
//  PageViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/20/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vcOne = [ViewControllerOne new];
    self.vcTwo = [ViewControllerTwo new];
    self.vcThree = [ViewControllerThree new];
    self.vcFour = [ViewControllerFour new];
    self.vcFive = [ViewControllerFive new];
    self.vcSix = [ViewControllerSix new];
    
    
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageViewController.dataSource = self;
    
    [self.pageViewController setViewControllers:@[[self vcOne]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (viewController == self.vcOne) {
        return nil;
    } else if (viewController == self.vcTwo) {
        return self.vcOne;
    } else if (viewController == self.vcThree) {
        return self.vcTwo;
    } else if (viewController == self.vcFour) {
        return self.vcThree;
    } else if (viewController == self.vcFive) {
        return self.vcFour;
    } else {
        return self.vcFive;
    }

}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if (viewController == self.vcOne) {
        return self.vcTwo;
    } else if (viewController == self.vcTwo) {
        return self.vcThree;
    } else if (viewController == self.vcThree) {
        return self.vcFour;
    } else if (viewController == self.vcFour) {
        return self.vcFive;
    } else if (viewController == self.vcFive) {
        return self.vcSix;
    } else {
        return nil;
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
