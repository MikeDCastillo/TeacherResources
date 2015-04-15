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
#import "TimerViewController.h"
@import AVFoundation;

@interface AppDelegate ()

@property (nonatomic, assign) BOOL hasLaunched;
@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    GroupViewController *groupViewController = [GroupViewController new];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:groupViewController];
    self.window.rootViewController = navController;
    [AppearanceController setupAppearance];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
  
    return YES;
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSURL *timerSound = [[NSBundle mainBundle] URLForResource:@"alarm" withExtension:@"mp3"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:timerSound error:nil];
    [self.player play];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Time's Up!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        TimerViewController *timerVC = [TimerViewController new];
        [timerVC startButtonPressed ];
        [self.player stop];
    }]];
    
        [self.window.rootViewController presentViewController:alertController animated:YES completion:^{
            [self.player stop];
        }];

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[Timer sharedInstance] prepareForBackground];
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[Timer sharedInstance] loadFromBackground];
    [self.player stop];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
