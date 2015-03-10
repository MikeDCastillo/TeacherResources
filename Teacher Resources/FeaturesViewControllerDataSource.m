//
//  FeaturesViewControllerDataSource.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "FeaturesViewControllerDataSource.h"

static NSString *cellID = @"CellID";

@implementation FeaturesViewControllerDataSource


- (void)registerCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self iconImageNames].count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.layer.borderWidth = 5.0f;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    
    UIImage *image = [UIImage imageNamed:[self iconImageNames][indexPath.row]];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
//    imageView.frame = cell.frame;
    [cell.contentView addSubview:imageView];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}


- (NSArray *)iconImageNames {
    
    return @[@"randomGroup.png", @"randomList.png", @"nameFromAHat.png", @"cooperativeLearning.png", @"theWilliams.png", @"seatingChart.png"];

}


@end
