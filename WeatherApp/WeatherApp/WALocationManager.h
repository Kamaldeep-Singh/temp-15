//
//  WMLocationManager.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/6/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <WeatherSDK/WMTypes.h>

@interface WALocationManager : NSObject

+ sharedManager;

-(void) startWithHandler:(WMLocationUpdateBlock)handler;
-(void) stop;

@end
