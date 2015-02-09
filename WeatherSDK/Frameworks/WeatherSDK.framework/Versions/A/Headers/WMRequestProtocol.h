//
//  WMRequest.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import <Foundation/Foundation.h>

@protocol WMRequestProtocol <NSObject>
/**
 *  Starts the request
 *
 */
-(void) start;

/**
 *  Tries to cancel the request.
 *
 */
-(void) cancel;

/**
 *  Stops further execution of the request's thread until a response
 *  is received.
 *
 */
@optional
-(void) waitUntilDone;

@end
