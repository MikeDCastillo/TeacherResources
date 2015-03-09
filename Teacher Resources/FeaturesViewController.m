//
//  FeaturesViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "FeaturesViewController.h"

@interface FeaturesViewController ()

@end

@implementation FeaturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar = [[UINavigationBar alloc]init];
    [self.view addSubview:self.navBar];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    self.dataSource = [FeaturesViewControllerDataSource new];
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self;
    [self.dataSource registerCollectionView:self.collectionView];
    [self.view addSubview:self.collectionView];
    
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
