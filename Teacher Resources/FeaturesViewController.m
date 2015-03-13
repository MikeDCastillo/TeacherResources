//
//  FeaturesViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "FeaturesViewController.h"
#import "UIColor+Category.h"

@interface FeaturesViewController ()

@end

@implementation FeaturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Features"; 
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    layout.sectionInset = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);

    self.dataSource = [FeaturesViewControllerDataSource new];
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self;
    [self.dataSource registerCollectionView:self.collectionView];
    [self.view addSubview:self.collectionView];
    
}

- (void)updateWithGroup:(Group *)group {
    
    self.group = group;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(180,180);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: {
            
            RandomizedGroupsViewController *randomizedGroupsViewController = [RandomizedGroupsViewController new];
            
            [randomizedGroupsViewController updateWithGroup:self.group];
            
            [self.navigationController pushViewController:randomizedGroupsViewController animated:YES];
            
            
            break; }
        case 1: {
            
            StudentListViewController *listViewController = [StudentListViewController new];
            
            [listViewController updateWithGroup:self.group];
            
            [self.navigationController pushViewController:listViewController animated:YES];
            
            
            break; }
        case 2: {
            
            
            break; }
        case 3: {
            
            break; }
        case 4: {
            
            TimerViewController *timerViewController = [TimerViewController new];
            
            [self.navigationController pushViewController:timerViewController animated:YES];
            
            break; }
        case 5: {
            
        
            break; }
            
            
        default:
            break;
    }
    

    
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
