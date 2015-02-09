//
//  WMQueryResult.h
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <UIKit/UIKit.h>

@interface WMCityWeather : NSObject
@property (readonly, nonatomic) NSString *cityId;
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *country;
@property (readonly, nonatomic) NSTimeInterval sunrise;
@property (readonly, nonatomic) NSTimeInterval sunset;
/**  an array of more weather info objects  */
@property (readonly, nonatomic) NSArray *weatherInfos;

- (instancetype) initWithDictionary:(NSDictionary *)dict;

@end

@interface WMCityWeather (WeatherMetrics)
@property (readonly, nonatomic) float temperature;
@property (readonly, nonatomic) float humidity;
@property (readonly, nonatomic) float minTemperature;
@property (readonly, nonatomic) float maxTemperature;
@property (readonly, nonatomic) float pressure;
@property (readonly, nonatomic) float seaLevelPressure;
@property (readonly, nonatomic) float groundLevelPressure;
@end

@interface WMCityWeather (Wind)
@property (readonly, nonatomic) float speed;
@property (readonly, nonatomic) float degree;
@property (readonly, nonatomic) float gust;
@end

@interface WMCityWeather (Clouds)
@property (readonly, nonatomic) float all;
@end

@interface WMCityWeather (Rain)
@property (readonly, nonatomic) float rain;
@end

@interface WMCityWeather (Snow)
@property (readonly, nonatomic) float snow;
@end


#pragma mark - More Weather Info

@interface WMWeatherInfo : NSObject
@property (readonly, nonatomic) NSString *desc;
@property (readonly, nonatomic) UIImage *icon;
@end
