//
//  WMQueryOperation.m
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import "WMQueryOperation.h"
#import "WMUtils.h"

@interface WMQueryOperation ()
@property (nonatomic, strong) id<WMParam> query;
@property (nonatomic, assign) Class resultClass;
@property (nonatomic, copy) WMQueryResultBlock completionHandler;
@end

@implementation WMQueryOperation

-(instancetype) initWithQuery:(id<WMParam>)query
                  resultClass:(Class)resultClass
                   completion:(WMQueryResultBlock)completion;
{
    self = [super init];
    if (self) {
        self.query = query;
        self.completionHandler = completion;
        self.resultClass = resultClass;
    }
    return self;
}

-(void) main
{
    __weak WMQueryOperation *weakSelf = self;
    NSString *surl = [self.query.query
              stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Making request to %@", surl);
    
    NSURL *url = [NSURL URLWithString:surl];
    NSURLRequest *request = [NSURLRequest
                             requestWithURL:url
                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                             timeoutInterval:[WMUtils timeout]];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.completionHandler(nil, error);
            [weakSelf done];
        });
        return;
    }
    if (data) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingMutableLeaves
                                          error:&error];
        NSLog(@"%@", json);
        //  Oops! json parsing failed
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.completionHandler(nil, error);
                [weakSelf done];
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *arr = [NSMutableArray array];
            NSArray *list = json[@"list"];
            if (list) {
                for (NSDictionary *dict in list) {
                    id obj = [[self.resultClass alloc] initWithDictionary:dict];
                    [arr addObject:obj];
                }
            } else {
                [arr addObject:[[self.resultClass alloc] initWithDictionary:json]];
            }
            
            weakSelf.completionHandler(arr, nil);
            [weakSelf done];
        });
    }
}

- (void)dealloc
{
    self.query = nil;
    self.completionHandler = nil;
}

@end
