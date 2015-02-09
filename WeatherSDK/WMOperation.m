//
//  WMOperation.m
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import "WMOperation.h"
#import <UIKit/UIKit.h>

@interface WMOperation () {
    BOOL executing;
    BOOL finished;
    UIBackgroundTaskIdentifier bgId;
}
@end

@implementation WMOperation

-(instancetype) init
{
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
        bgId = UIBackgroundTaskInvalid;
    }
    return self;
}

-(BOOL) isConcurrent
{
    return YES;
}

-(BOOL) isExecuting
{
    return executing;
}

-(BOOL) isFinished
{
    return finished;
}

-(void) start
{
    NSLog(@"starting operation..");
    if (self.isCancelled) {
        [self cancelled];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self main];
}

-(void) done
{
    bgId = UIBackgroundTaskInvalid;
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

-(NSError *) cancelled
{
    [self done];
    NSError *err = [NSError errorWithDomain:@"" code:-1
                                   userInfo:@{NSLocalizedDescriptionKey: @"Cancelled"}];
    return err;
}

-(void) waitUntilDone
{
    @autoreleasepool {
        while (!self.isFinished) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                     beforeDate:[NSDate distantFuture]];
        }
    }
}

-(void) startBackgroundTask
{
    bgId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundTask];
    }];
}

-(void) endBackgroundTask
{
    NSAssert(bgId, @"Invalid background task identifier!");
    [[UIApplication sharedApplication] endBackgroundTask:bgId];
    [self done];
}
@end
