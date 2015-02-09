//
//  WMUtils.m
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import "WMUtils.h"

@implementation WMUtils

+(NSString *) serverUrl
{
    return @"http://api.openweathermap.org/data/2.5";
}

+(NSString *) apiKey
{
    return @"9bffd9f5567d73c4c58b0f958ca559f3";
}

+(NSTimeInterval) timeout
{
    return 45;
}

@end
