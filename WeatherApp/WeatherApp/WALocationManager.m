//
//  WMLocationManager.m
//  WeatherSDK
//
//  Created by Kamaldeep on 2/6/15.
//
//

#import "WALocationManager.h"

@interface WALocationManager () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (copy, nonatomic) WMLocationUpdateBlock handler;
@end

@implementation WALocationManager
static WALocationManager *wmLocationMgr = nil;

+ sharedManager
{
    if (!wmLocationMgr) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            wmLocationMgr = [[self alloc] init];
        });
    }
    return wmLocationMgr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        CLLocationManager *lm = [[CLLocationManager alloc] init];
        lm.delegate = self;
        lm.distanceFilter = 1000;
        self.locationManager = lm;
    }
    return self;
}

-(void) startWithHandler:(WMLocationUpdateBlock)handler
{
    wmLocationMgr.handler = handler;
    [wmLocationMgr.locationManager startUpdatingLocation];
}

-(void) stop
{
    wmLocationMgr.handler = nil;
    [wmLocationMgr.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    wmLocationMgr.handler([locations lastObject], nil);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    wmLocationMgr.handler(nil, error);
}

@end
