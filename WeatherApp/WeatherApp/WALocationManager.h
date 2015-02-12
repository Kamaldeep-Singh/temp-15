//
//  WMLocationManager.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/6/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^WALocationUpdateBlock)(CLLocation *newLocation, NSError *error);

@interface WALocationManager : NSObject

+ sharedManager;

-(void) startWithHandler:(WALocationUpdateBlock)handler;
-(void) stop;

@end
