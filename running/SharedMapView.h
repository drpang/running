//
//  SharedMapView.h
//  running
//
//  Created by pang on 15/11/24.
//  Copyright © 2015年 庞浩斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/MAMapKit.h>

@interface SharedMapView : NSObject

@property (nonatomic, readonly) MAMapView *mapView;

+ (instancetype)sharedInstance;

- (void)stashMapViewStatus;
- (void)popMapViewStatus;

@end
