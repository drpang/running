//
//  GPSLocationManager.m
//  running
//
//  Created by pang on 15/11/30.
//  Copyright © 2015年 庞浩斌. All rights reserved.
//

#import "GPSLocationManager.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation GPSLocationManager 
static GPSLocationManager *instance = nil;
+ (instancetype)shareGPSLocationManager{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[GPSLocationManager alloc]init];
        }
    }
    return instance;
}

- (void)initLocation
{
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        //定位初始化
        _locationManager=[[CLLocationManager alloc] init];
//        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];//开启定位
    }
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8) {
        [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
    }
    // 开始定位
    [_locationManager startUpdatingLocation];
}

@end
