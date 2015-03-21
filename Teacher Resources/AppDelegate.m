//
//  AppDelegate.m
//  Teacher Resources
//
//  Created by Parker Rushton on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "AppDelegate.h"
#import "GroupViewController.h"
#import "Timer.h"
#import "AppearanceController.h"
#import "PageViewController.h"


@interface AppDelegate ()

@property (nonatomic, strong) GroupViewController *groupViewController;
@property (nonatomic, assign) BOOL hasLaunched;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    GroupViewController *groupViewController = [GroupViewController new];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:groupViewController];
    self.window.rootViewController = navController;
    [AppearanceController setupAppearance];
    [self.window makeKeyAndVisible];
    
    [self updateLaunchCount];
    

    return YES;
}

- (void) updateLaunchCount {
    NSInteger launchCountInteger = [[NSUserDefaults standardUserDefaults] integerForKey:@"launchKey"];
    
    if (self.hasLaunched == YES) {
    }
    else {
        self.hasLaunched = YES;
        
        PageViewController *pageViewController = [PageViewController new];
        
        [self.groupViewController presentViewController:pageViewController animated:YES completion:nil];
    }
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:launchCountInteger forKey:@"launchKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[Timer sharedInstance] prepareForBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[Timer sharedInstance] loadFromBackground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
    }
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
