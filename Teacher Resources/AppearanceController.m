//
//  AppearanceController.m
//  Teacher Resources
//
//  Created by Parker Rushton on 3/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "AppearanceController.h"
#import "AppDelegate.h"

@implementation AppearanceController

+(void)setupAppearance {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                        [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"Chalkduster" size:24], NSFontAttributeName, nil]];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

@end
