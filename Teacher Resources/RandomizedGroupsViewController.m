//
//  RandomizedGroupsViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "RandomizedGroupsViewController.h"
#import "RandomizedViewControllerDataSource.h"
#import "UIColor+Category.h"

@interface RandomizedGroupsViewController ()


@property (strong, nonatomic) IBOutlet RandomizedViewControllerDataSource *datasource;

@end

@implementation RandomizedGroupsViewController

static NSString * const reuseIdentifier = @"studentCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    self.title = @"Random Groups";
    
    self.collectionView.backgroundColor = [UIColor slateColor];
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.datasource = [RandomizedViewControllerDataSource new];
    self.collectionView.dataSource = self.datasource;
    self.collectionView.delegate = self;
    [self.datasource registerCollectionView:self.collectionView];
    [self.view addSubview:self.collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reload:(id)sender {
    [self.datasource randomizeAndReload];
}

@end
