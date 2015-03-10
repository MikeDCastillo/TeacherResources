//
//  RandomizedViewControllerDataSource.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "RandomizedViewControllerDataSource.h"
#import "MembersCollectionViewCell.h"

@interface RandomizedViewControllerDataSource ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *members;

@end

@implementation RandomizedViewControllerDataSource


- (RandomizedViewControllerDataSource *)init {
    self = [super init];
    if (self) {
        [self randomMemberList];
    }
    return self;
}

- (void)registerCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:[MembersCollectionViewCell class] forCellWithReuseIdentifier:@"memberCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 18;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MembersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"memberCell" forIndexPath:indexPath];
    
    [cell configureCellWithName:self.members[indexPath.item]];
    [cell setBackgroundColor:[UIColor blueColor]];
    return cell;
}

- (void)randomMemberList
{
    NSMutableArray *array = [NSMutableArray arrayWithArray: @[@"Parker", @"Ethan", @"Jason", @"Paul", @"David", @"Christian", @"Gamma", @"Wagner", @"Ryan", @"Cal", @"Shawn", @"Ross", @"Gabe", @"Julien", @"Jake", @"Jordan", @"Trace", @"Mentor"]];
    
    self.members = [self shuffleArray:array];
}

- (NSArray *)shuffleArray:(NSMutableArray *)array
{
    NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    return array;
}

- (void)randomizeAndReload {
    [self randomMemberList];
    [self.collectionView reloadData];
}

@end
