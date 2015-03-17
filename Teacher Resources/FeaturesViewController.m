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

- (void)updateWithGroup:(Group *)group {
    
    self.group = group;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@-Features", self.group.title];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor chalkboardGreen];
    
    layout.sectionInset = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);

    self.dataSource = [FeaturesViewControllerDataSource new];
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self;
    [self.dataSource registerCollectionView:self.collectionView];
    [self.view addSubview:self.collectionView];
    
//    self.collectionView.contentSize =
    
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
            
            TimerViewController *timerViewController = [TimerViewController new];
            [self.navigationController pushViewController:timerViewController animated:YES];

            break; }
            
        default:
            break;
    }
}

@end
