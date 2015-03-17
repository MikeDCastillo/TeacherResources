//
//  AppearanceController.m
//  Teacher Resources
//
//  Created by Parker Rushton on 3/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "AppearanceController.h"
#import "AppDelegate.h"
#import "UIColor+Category.h"

@implementation AppearanceController

+(void)setupAppearance {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    //Navigation Bar
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                        [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"Chalkduster" size:24], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTintColor:[UIColor chalkboardGreen]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

}

@end
