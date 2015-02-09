//
//  WMTypes.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//


#import <UIKit/UIKit.h>
#import "WMCityWeather.h"

/**
 *  This header defines the Flickr API callbacks.
 */
#ifndef WeatherSDK_WMTypes_h
#define WeatherSDK_WMTypes_h

/**
 *  A result block for general sdk queries.
 */
typedef void (^WMQueryResultBlock)(NSArray *cities, NSError *error);

typedef void (^WMLocationUpdateBlock)(CLLocation *newLocation, NSError *error);

/**
 *  A result block for download photo query.
 */
typedef void (^WMPhotoQueryResultBlock)(UIImage *image, NSError *error);


#endif
