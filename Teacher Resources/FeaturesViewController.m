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
    
    self.title = @"Tools";
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor chalkboardGreen];
    
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

    return CGSizeMake((self.view.frame.size.width / 2) - 8,180);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: {
            
            RandomizedGroupsViewController *randomizedGroupsViewController = [RandomizedGroupsViewController new];
            [randomizedGroupsViewController updateWithGroup:self.group];
            [self.navigationController pushViewController:randomizedGroupsViewController animated:YES];
        
            break; }
        case 1: {
            
            StudentListShufflerViewController *studentListShufflerViewController = [StudentListShufflerViewController new];
            [studentListShufflerViewController updateWithGroup:self.group];
            [self.navigationController pushViewController:studentListShufflerViewController animated:YES];
            
            break; }
        case 2: {
            
            NameFromHatViewController *nameFromHatViewController = [NameFromHatViewController new];
            [nameFromHatViewController updateWithGroup:self.group];
            [self.navigationController pushViewController:nameFromHatViewController animated:YES];
            
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
