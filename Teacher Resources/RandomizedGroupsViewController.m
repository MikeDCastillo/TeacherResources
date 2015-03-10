//
//  RandomizedGroupsViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "RandomizedGroupsViewController.h"
#import "RandomizedViewControllerDataSource.h"

@interface RandomizedGroupsViewController ()


@property (strong, nonatomic) IBOutlet RandomizedViewControllerDataSource *datasource;

@end

@implementation RandomizedGroupsViewController

static NSString * const reuseIdentifier = @"studentCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Random Groups";
    
    self.datasource = [RandomizedViewControllerDataSource new];
    
    [self.datasource registerCollectionView:self.collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reload:(id)sender {
    [self.datasource randomizeAndReload];
}

@end
