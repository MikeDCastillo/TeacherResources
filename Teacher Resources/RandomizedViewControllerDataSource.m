//
//  RandomizedViewControllerDataSource.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "RandomizedViewControllerDataSource.h"
#import "MembersCollectionViewCell.h"
#import "StudentController.h"

@interface RandomizedViewControllerDataSource ()

@property (nonatomic,strong) MembersCollectionViewCell * cell;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *members;

@end

@implementation RandomizedViewControllerDataSource


@synthesize cell;

-(void)registerCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:[MembersCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
}

-(MembersCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *name = [NSString stringWithFormat:@"%@", [[StudentController SharedInstance].students objectAtIndex:indexPath.row]];
    [cell.name setText:name];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[StudentController SharedInstance].students count];
}

@end