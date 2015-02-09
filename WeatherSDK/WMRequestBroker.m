//
//  WMRequestBroker.m
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import "WMRequestBroker.h"
#import "WMRequest+Internal.h"

@interface WMRequestBroker ()
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation WMRequestBroker

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSOperationQueue *q = [[NSOperationQueue alloc] init];
        q.maxConcurrentOperationCount = 5;
        q.name = @"weather-queue";
        self.queue = q;
    }
    return self;
}

+(instancetype) sharedBroker
{
    static WMRequestBroker *_wmBroker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _wmBroker = [[self alloc] init];
    });
    return _wmBroker;
}

-(void) dispatchRequest:(WMRequest *)request
{
    [self.queue addOperation:request.operation];
}

-(void) cancelRequest:(WMRequest *)request
{
    [request.operation cancel];
}

-(void) cancelAllOperations
{
    [self.queue cancelAllOperations];
}
@end
