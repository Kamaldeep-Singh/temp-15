//
//  WMUtils.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import <Foundation/Foundation.h>

@interface WMUtils : NSObject
+(NSString *) serverUrl;
+(NSString *) apiKey;
+(NSTimeInterval) timeout;
@end
