//
//  WMRequest.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import <Foundation/Foundation.h>
#import "WMParam.h"
#import "WMTypes.h"
#import "WMCurrentWeatherQuery.h"
#import "WMRequestProtocol.h"

/**
 *  Instances of this class are used to send a request to the
 *  open weather server satisfying a query with a result.
 *
 */
@interface WMRequest : NSObject <WMRequestProtocol>

/**
 *  Creates a request to fetch the data for current weather conditions.
 *
 *  @param  query   An instance of WMCurrentWeatherQuery as params to the request
 *  @param  completion   A completion block to deliver the result/error
 *
 *  @return an instance of WMRequest
 */
+(instancetype) requestForCurrentWeather:(WMCurrentWeatherQuery *)query
                              completion:(WMQueryResultBlock)completion;

@end