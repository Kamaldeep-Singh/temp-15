//
//  WMQueryOperation.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import "WMOperation.h"
#import "WMParam.h"
#import "WMTypes.h"

@interface WMQueryOperation : WMOperation
-(instancetype) initWithQuery:(id<WMParam>)query
                  resultClass:(Class)resultClass
                   completion:(WMQueryResultBlock)completion;
@end
