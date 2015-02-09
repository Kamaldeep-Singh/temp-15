//
//  WMParam.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import <Foundation/Foundation.h>

@protocol WMParam <NSObject>
/**  The query used in the rest call */
@property (nonatomic, strong) NSString *query;
@end
