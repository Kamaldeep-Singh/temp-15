//
//  WMOperation.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import <Foundation/Foundation.h>

/**
 *  A subclass of NSOperation implementing custom behavior.
 *  This class can be subclassed by other operation classes
 *  for the sdk.
 */
@interface WMOperation : NSOperation

/**
 *  Subclasses can call this as a result of operation cancel.
 *  This will update the internal state of NSOperation.
 *
 *  @return The error specifying cancellation.
 */
-(NSError *) cancelled;

/**
 *  Subclasses can call this to update the internal flags
 *  marking completion of the operation.
 */
-(void) done;

/**
 *  Pass this message to receiver to request application for
 *  some background processing time.
 */
-(void) startBackgroundTask;

/**
 *  Pass this message to receiver to end an existing background
 *  task request.
 */
-(void) endBackgroundTask;

@end
