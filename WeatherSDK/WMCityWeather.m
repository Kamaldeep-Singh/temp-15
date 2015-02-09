//
//  WMQueryResult.m
//  WeatherSDK
//
//  Created by Kamaldeep on 2/7/15.
//
//

#import "WMCityWeather.h"

@interface WMCityWeather ()
@property (readwrite, strong, nonatomic) NSString *cityId;
@property (readwrite, assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (readwrite, strong, nonatomic) NSString *name;
@property (readwrite, strong, nonatomic) NSString *country;
@property (readwrite, strong, nonatomic) NSArray *weatherInfos;
@property (readwrite, assign, nonatomic) NSTimeInterval sunrise;
@property (readwrite, assign, nonatomic) NSTimeInterval sunset;
@property (readwrite, assign, nonatomic) float temperature;    //-273.15
@property (readwrite, assign, nonatomic) float humidity;
@property (readwrite, assign, nonatomic) float minTemperature;
@property (readwrite, assign, nonatomic) float maxTemperature;
@property (readwrite, assign, nonatomic) float pressure;
@property (readwrite, assign, nonatomic) float seaLevelPressure;
@property (readwrite, assign, nonatomic) float groundLevelPressure;
@property (readwrite, assign, nonatomic) float speed;
@property (readwrite, assign, nonatomic) float degree;
@property (readwrite, assign, nonatomic) float gust;
@property (readwrite, assign, nonatomic) float all;
@property (readwrite, assign, nonatomic) float rain;
@property (readwrite, assign, nonatomic) float snow;
@end

@interface WMWeatherInfo ()
@property (readwrite, strong, nonatomic) NSString *desc;
@property (readwrite, strong, nonatomic) NSString *icon;

-(instancetype) initWithDictionary:(NSDictionary *)dict;

@end

@implementation WMCityWeather

- (instancetype) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.cityId = dict[@"id"];
        self.coordinate = CLLocationCoordinate2DMake([dict[@"lat"] doubleValue],
                                                     [dict[@"lon"] doubleValue]);
        self.name = dict[@"name"];
        self.country = dict[@"sys"][@"country"];

        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *w in dict[@"weather"]) {
            WMWeatherInfo *info = [[WMWeatherInfo alloc] initWithDictionary:w];
            [arr addObject:info];
        }
        self.weatherInfos = arr;
        
        self.sunrise = [dict[@"sunrise"] doubleValue];
        self.sunset = [dict[@"sunset"] doubleValue];
        self.temperature = [dict[@"main"][@"temp"] floatValue] - 273.15;
        self.humidity = [dict[@"main"][@"humidity"] floatValue];
        self.minTemperature = [dict[@"main"][@"temp_min"] floatValue];
        self.maxTemperature = [dict[@"main"][@"temp_max"] floatValue];
        self.pressure = [dict[@"main"][@"pressure"] floatValue];
        self.seaLevelPressure = [dict[@"main"][@"sea_level"] floatValue];
        self.groundLevelPressure = [dict[@"main"][@"grnd_level"] floatValue];
        self.speed = [dict[@"wind"][@"speed"] floatValue];
        self.degree = [dict[@"wind"][@"deg"] floatValue];
        self.gust = [dict[@"main"][@"gust"] floatValue];
        self.all = [dict[@"clouds"][@"all"] floatValue];
        self.rain = [dict[@"rain"][@"3h"] floatValue];
        self.snow = [dict[@"snow"][@"3h"] floatValue];
    }
    return self;
}

@end

@implementation WMWeatherInfo

-(instancetype) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.desc = dict[@"description"];
        self.icon = dict[@"icon"];
    }
    return self;
}
@end
