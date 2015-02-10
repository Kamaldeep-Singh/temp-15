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

/**
 *  Instances of this class do the actual work of firing
 *  search requests to the server
 */
@interface WMQueryOperation : WMOperation
-(instancetype) initWithQuery:(id<WMParam>)query
                  resultClass:(Class)resultClass
                   completion:(WMQueryResultBlock)completion;
@end
