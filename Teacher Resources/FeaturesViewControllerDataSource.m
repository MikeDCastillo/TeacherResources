//
//  FeaturesViewControllerDataSource.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "FeaturesViewControllerDataSource.h"
#import "FeaturesCollectionViewCell.h"

static NSString *cellID = @"CellID";

@implementation FeaturesViewControllerDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        [FeaturesCollectionViewCell new];
    }
    return self;
}


- (void)registerCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:[FeaturesCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self iconImageNames].count;
    
}

- (FeaturesCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FeaturesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    NSArray *subviews = [cell.contentView subviews];
    
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    
//    cell.layer.borderWidth = 5.0f;
//    cell.layer.borderColor = [UIColor blackColor].CGColor;
    
    UIImage *image = [UIImage imageNamed:[self iconImageNames][indexPath.row]];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    imageView.frame = CGRectMake(55, 45, 60, 60);

    [cell.contentView addSubview:imageView];
    cell.footerLabel.text = [self iconFooterNames][indexPath.row];
    cell.footerLabel.font = [UIFont fontWithName:@"Chalkduster" size:20];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}



- (NSArray *)iconFooterNames {
    
    return @[@"Randomizer", @"Student List", @"Name From Hat", @"Timer"];
    
}



- (NSArray *)iconImageNames {
    
    return @[@"shuffle.png", @"list1.png", @"magician.png", @"sandglass.png"];

}


@end
