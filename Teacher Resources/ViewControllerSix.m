//
//  ViewControllerSix.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/20/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "ViewControllerSix.h"

@interface ViewControllerSix ()

@end

@implementation ViewControllerSix

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    [button addTarget:self action:@selector(dismissOnboarding) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@" Launch App " forState:UIControlStateNormal];
    
    
}

- (void)dismissOnboarding {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
