//
//  ViewControllerTwo.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/20/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "ViewControllerTwo.h"

@interface ViewControllerTwo ()

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"Group"];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    imageView.image = image;
    
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
