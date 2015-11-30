//
//  GPSLocationManager.h
//  running
//
//  Created by pang on 15/11/30.
//  Copyright © 2015年 庞浩斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocationManager;
@interface GPSLocationManager : NSObject 
@property (nonatomic, strong) CLLocationManager *locationManager;
+ (instancetype)shareGPSLocationManager;
- (void)initLocation;
@end
