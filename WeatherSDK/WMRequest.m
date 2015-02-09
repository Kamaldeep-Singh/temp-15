//
//  WMRequest.m
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import "WMRequest.h"
#import "WMRequest+Internal.h"
#import "WMQueryOperation.h"
#import "WMRequestBroker.h"
#import "WMRequest+Internal.h"

@interface WMRequest ()
@property (nonatomic, strong) id operation;
@end

@implementation WMRequest
@synthesize operation;

+(instancetype) requestForCurrentWeather:(WMCurrentWeatherQuery *)query
                              completion:(WMQueryResultBlock)completion
{
    WMRequest *request = [[self alloc] init];
    WMQueryOperation *op = [[WMQueryOperation alloc]
                            initWithQuery:query
                            resultClass:[WMCityWeather class]
                            completion:completion];
    request.operation = op;
    return request;
}

-(void) start
{
    [[WMRequestBroker sharedBroker] dispatchRequest:self];
}

-(void) cancel
{
    [self.operation cancel];
}

-(void) waitUntilDone
{
    [self.operation waitUntilDone];
}

@end
