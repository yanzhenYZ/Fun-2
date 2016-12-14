//
//  YZLocationManager.m
//  yingke
//
//  Created by yanzhen on 16/12/9.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "YZLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface YZLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, assign) BOOL locationServicesEnabled;
@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinate;

@end

@implementation YZLocationManager

static id instance;
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[super allocWithZone:zone];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [[CLLocationManager alloc] init];
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.distanceFilter = 100;
        _manager.delegate = self;
        if (![CLLocationManager locationServicesEnabled]) {
            _locationServicesEnabled = YES;
        }else{
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (kCLAuthorizationStatusNotDetermined == status) {
                [_manager requestWhenInUseAuthorization];
            }
        }
    }
    return self;
}
#pragma mark - OUT
- (void)startUpdatingLocation{
    [_manager startUpdatingLocation];
}

- (void)getLocationCoordinate2D:(void(^)(BOOL locationServicesEnabled,NSString *latitude,NSString *longitude))block{
    if (block) {
        NSString *lat = [NSString stringWithFormat:@"%.6f",self.currentCoordinate.latitude];
        NSString *lo = [NSString stringWithFormat:@"%.6f",self.currentCoordinate.longitude];
        block(self.locationServicesEnabled,lat,lo);
    }
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    if (locations.count > 0) {
        _currentCoordinate = locations.firstObject.coordinate;
    }else{
        _currentCoordinate = CLLocationCoordinate2DMake(0, 0);
    }
}
@end
