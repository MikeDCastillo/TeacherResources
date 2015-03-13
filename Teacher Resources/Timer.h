//
//  Timer.h
//  Timer
//  Created by sombra on 2015-02-16.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const secondTickNotification = @"secondTick";
static NSString * const timerCompleteNotification = @"timerCompleteNotification";
static NSString *expiryDate = @"expiryDate";


@interface Timer : NSObject

@property (nonatomic,assign) NSInteger minutes;
@property (nonatomic,assign) NSInteger seconds;
@property (nonatomic,assign) BOOL isOn;

+ (Timer *)sharedInstance;

- (void)startTimer;
- (void)cancelTimer;
- (void)prepareForBackground;
- (void)loadFromBackground;

@end
