//
//  WMCurrentWeatherQuery.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import <Foundation/Foundation.h>
#import "WMParam.h"
#import <CoreLocation/CLLocation.h>

@interface WMCurrentWeatherQuery : NSObject <WMParam>

+ weatherQueryWithLatitude:(double)lat longitude:(double)lon;
+ weatherQueryWithCityName:(NSString *)city;

@end
