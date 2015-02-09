//
//  WMRequestBroker.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import <Foundation/Foundation.h>
#import "WMRequest.h"

/**
 *  This is a shared message broker for managing the request
 *  and actually running the operation in the request.
 *  Other brokers can be created for different set of operations
 */
@interface WMRequestBroker : NSObject
+(instancetype) sharedBroker;

-(void) dispatchRequest:(WMRequest *)request;
-(void) cancelAllOperations;
@end
