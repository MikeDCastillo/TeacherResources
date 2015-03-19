//
//  Timer.m
//  The Pomodoro
//
//  Created by sombra on 2015-02-16.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"

@interface Timer ()

@property (strong, nonatomic) NSDate *expirationDate;

@end



@implementation Timer

+ (Timer *)sharedInstance {
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc] init];
    });
    return sharedInstance;
}

- (void)startTimer {
    self.isOn = YES;
    [self isActive];
}

- (void)cancelTimer {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(decreaseSecond) object:nil];
}

- (void)endTimer {
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:timerCompleteNotification object:nil];
    
}

- (void)pauseTimer {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(decreaseSecond) object:nil];
    
}

- (void)decreaseSecond {
    
    if (self.seconds > 0)
    {
        self.seconds--;
        
        NSDictionary *timerDictionary = @{@"Minutes": @(self.minutes), @"Seconds": @(self.seconds)};
        [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:self userInfo:timerDictionary];
    }
    else if (self.seconds == 0 && self.minutes > 0) {
        
        self.minutes--;
        self.seconds = 59;
        NSDictionary *timerDictionary = @{@"Minutes": @(self.minutes), @"Seconds": @(self.seconds)};
        [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:self userInfo:timerDictionary];
    }
    else {
        [self endTimer];
    }
}

- (void)isActive {
    if (self.isOn) {
        [self performSelector:@selector(isActive) withObject:nil afterDelay:1.0];
        [self decreaseSecond];
    }
}


- (void)prepareForBackground {
    [[NSUserDefaults standardUserDefaults] setObject:self.expirationDate forKey:expiryDate];
}

- (void)loadFromBackground {
    self.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:expiryDate];
    NSTimeInterval seconds = [self.expirationDate timeIntervalSinceNow];
    self.minutes = seconds / 60;
    self.seconds = seconds - (seconds / 60);
    
}
@end
