//
//  AppDelegate.m
//  WenMemory
//
//  Created by LHWen on 2018/9/23.
//  Copyright © 2018年 LHWen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundUpdateTask;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

/**
 iOS 后台模式 可以让应用 最多 有10分钟的时间在后台长久运行。
 这个时间可以用来，清除本地缓存、发送统计数据等工作。
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self beingBackgroundUpdateTask];
    
    // 需要长久运行代码 background模式最长运行时长是10分钟，超过10分钟将不再运行应用
    for (int i = 0; i < 100; i++) {
        NSLog(@"background output i is %d", i);
    }
    
    // 延迟处理，会在重新唤醒应用的时候进行打印
    //    double delayInFive = 3.0;
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInFive * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^{
    //
    //        // 延迟进行打印
    //        for (int i = 0; i < 100; i++) {
    //            NSLog(@"background output i is %d", i);
    //        }
    //
    //    });
    
    [self endBackgroundUpdateTask];
}

- (void)beingBackgroundUpdateTask {
    
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void)endBackgroundUpdateTask {
    
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundUpdateTask];
    
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
