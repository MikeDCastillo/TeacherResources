//
//  MembersCollectionViewCell.h
//  Teacher Resources
//
//  Created by Christian Monson on 3/10/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MembersCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *name;
@property (nonatomic,assign) CGRect labelFrame;


-(void)setupViews;
-(void)updateLabelFrame:(CGRect)frame;

@end

