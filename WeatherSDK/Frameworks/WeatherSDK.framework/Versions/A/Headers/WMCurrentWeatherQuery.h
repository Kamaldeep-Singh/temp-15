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

/**
 *  Instances of this class are used to create parameters for
 *  running the server request.
 *
 */
@interface WMCurrentWeatherQuery : NSObject <WMParam>

+ weatherQueryWithLatitude:(double)lat longitude:(double)lon;
+ weatherQueryWithCityName:(NSString *)city;

@end
