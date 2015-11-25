//
//  AppDelegate.m
//  running
//
//  Created by pang on 15/11/24.
//  Copyright © 2015年 庞浩斌. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapNaviKit/AMapNaviKit.h>

@interface AppDelegate ()<AMapNaviManagerDelegate>
@property (nonatomic, strong) AMapNaviManager *naviManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AMapNaviServices sharedServices].apiKey =@"487357ce89e3fe1e945634d2a7053432";
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    [MAMapServices sharedServices].apiKey = @"487357ce89e3fe1e945634d2a7053432";
    
    NSLog(@"bundleIdentifier %@",bundleIdentifier);
    [self initNaviManager];
    [self routeCal];
    return YES;
}

- (void)initNaviManager
{
    if (_naviManager == nil)
    {
        _naviManager = [[AMapNaviManager alloc] init];
        [_naviManager setDelegate:self];
    }
}

- (void)routeCal
{
    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:39.989614 longitude:116.481763];
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:39.983456 longitude:116.315495];
    
    NSArray *startPoints = @[startPoint];
    NSArray *endPoints   = @[endPoint];
    
    //驾车路径规划（未设置途经点、导航策略为速度优先）
    [_naviManager calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:0];
    
    //步行路径规划
    [self.naviManager calculateWalkRouteWithStartPoints:startPoints endPoints:endPoints];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
