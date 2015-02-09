//
//  WMCurrentWeatherQuery.m
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import "WMCurrentWeatherQuery.h"
#import "WMUtils.h"

@implementation WMCurrentWeatherQuery
@synthesize query;

+ weatherQueryWithLatitude:(double)lat longitude:(double)lon
{
    WMCurrentWeatherQuery *q = [[self alloc] init];
    q.query = [NSString stringWithFormat:@"%@/weather?lat=%lf&lon=%lf",
                                            [WMUtils serverUrl], lat, lon];
    return q;
}

+ weatherQueryWithCityName:(NSString *)city
{
    WMCurrentWeatherQuery *q = [[self alloc] init];
    q.query = [NSString stringWithFormat:@"%@/find?q=%@&type=like",
                                            [WMUtils serverUrl], city];
    return q;
}

@end
