//
//  ViewController.m
//  running
//
//  Created by pang on 15/11/24.
//  Copyright © 2015年 庞浩斌. All rights reserved.
//

#import "ViewController.h"
#import "SharedMapView.h"
#import "GPSLocationManager.h"
//#import "PointModel.h"

@interface ViewController ()<MAMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic, weak) MAMapView *mapView;
@end

@implementation ViewController
{
    NSMutableArray *_dataList;
    CLLocationCoordinate2D commonPolylineCoords[2];
    CLLocationSpeed _cllocationSpeed;
    UILabel *_disTanceLable;
    CLLocation *_firstDot;
    CLLocation *_secondDot;
    CLLocationDistance _meters;
    BOOL _isDrawLine;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initMapView];
    _dataList = [NSMutableArray array];
    _meters = 0;
    //    [self createOverlay];
    [[GPSLocationManager shareGPSLocationManager]initLocation];
    [GPSLocationManager shareGPSLocationManager].locationManager.delegate = self;
    
}

- (void)initMapView
{
    if (_mapView == nil)
    {
        _mapView = [[SharedMapView sharedInstance] mapView];
    }
    
    [_mapView setFrame:self.view.bounds];
    
    [_mapView setDelegate:self];
    [self.view addSubview:_mapView];
    
    _disTanceLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, 200, 50)];
    [self.view addSubview:_disTanceLable];
    
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 5.f;
        polylineView.strokeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
        polylineView.lineJoinType = kMALineJoinRound;//连接类型
        polylineView.lineCapType = kMALineCapRound;//端点类型
        if (_cllocationSpeed > 1) {
            polylineView.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.8];
        }else{
            polylineView.strokeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
        }
        return polylineView;
    }
    return nil;
}

#pragma mark - CoreLocation Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *curLocation = [locations lastObject];
    
    if(curLocation.horizontalAccuracy > 0)
    {
        NSLog(@"当前位置：%f,%f +/- %.0f meters speed %f m/s",curLocation.coordinate.longitude,
              curLocation.coordinate.latitude,
              curLocation.horizontalAccuracy,
              curLocation.speed);
        _cllocationSpeed = curLocation.speed;
        if (!_isDrawLine) {
            commonPolylineCoords[0].latitude = curLocation.coordinate.latitude;
            commonPolylineCoords[0].longitude = curLocation.coordinate.longitude;
            _firstDot = [[CLLocation alloc]initWithLatitude:curLocation.coordinate.latitude longitude:curLocation.coordinate.longitude];
            [_mapView setCenterCoordinate:commonPolylineCoords[0]];
            _isDrawLine = YES;
        }else{
            commonPolylineCoords[1].latitude = curLocation.coordinate.latitude;
            commonPolylineCoords[1].longitude = curLocation.coordinate.longitude;
            _secondDot = [[CLLocation alloc]initWithLatitude:curLocation.coordinate.latitude longitude:curLocation.coordinate.longitude];
            MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:2];
            [_mapView addOverlay: commonPolyline];
            commonPolylineCoords[0].latitude = commonPolylineCoords[1].latitude;
            commonPolylineCoords[0].longitude = commonPolylineCoords[1].longitude;
            
            _meters += [_firstDot distanceFromLocation:_secondDot];
            _disTanceLable.text = [NSString stringWithFormat:@"%f米",_meters];
            _firstDot = [[CLLocation alloc]initWithLatitude:commonPolylineCoords[0].latitude longitude:commonPolylineCoords[0].longitude];
        }
        
        
    }
    
    if(curLocation.verticalAccuracy > 0)
    {
        NSLog(@"当前海拔高度：%.0f +/- %.0f meters",curLocation.altitude,curLocation.verticalAccuracy);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
