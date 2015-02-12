//
//  WAListViewController.m
//  WeatherApp
//
//  Created by Kamaldeep on 2/7/15.
//  Copyright (c) 2015 Elementum. All rights reserved.
//

#import "WAListViewController.h"
#import <WeatherSDK/WMRequest.h>
#import "WALocationManager.h"
#import "WAAddCityController.h"

@interface WMWeatherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@end

@interface WAListViewController () <WAAddCityDelegate>
@property (strong, nonatomic) NSMutableArray *places;
@property (strong, nonatomic) NSMutableArray *placesIcons;
@property (strong, nonatomic) NSOperationQueue *iconQueue;
@end

@implementation WAListViewController

static NSString * const cellId = @"WeatherCell";
static NSString *iconUrl = @"http://openweathermap.org/img/w/";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WeatherCell" bundle:nil]
         forCellReuseIdentifier:cellId];
    self.tableView.sectionFooterHeight = 64.0;
    
    self.places = [NSMutableArray array];
    self.placesIcons = [NSMutableArray array];
    
    self.iconQueue = [[NSOperationQueue alloc] init];
    self.iconQueue.name = @"icons-queue";

    [self updateWeatherForCurrentLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateWeatherForCurrentLocation
{
    //  Default entry
    WMCityWeather *currentLocation = [[WMCityWeather alloc]
                                      initWithDictionary:@{@"name":@"Current Location",
                                                           @"main":@{@"temperature":@0}}];
    [self.places addObject:currentLocation];
    [self.placesIcons addObject:[NSNull null]];

    __weak WAListViewController *weakSelf = self;
    
    //  Get the weather details for current location, change on every new update
    //  which is out of 1000m radius
    [[WALocationManager sharedManager]
     startWithHandler:^(CLLocation *newLocation, NSError *error){
         if (error) {
             NSLog(@"%@", error);
             return;    //do nothing, silently fail and show previous data
         }
         WMCurrentWeatherQuery *params = [WMCurrentWeatherQuery
                      weatherQueryWithLatitude:newLocation.coordinate.latitude
                      longitude:newLocation.coordinate.longitude];
         
         [[WMRequest requestForCurrentWeather:params
                           completion:^(NSArray *result, NSError *error){
               WMCityWeather *place = [result lastObject];
               weakSelf.places[0] = place;
               [weakSelf.tableView reloadData];
         }] start];
     }];
}

#pragma mark - UITableView Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                          forIndexPath:indexPath];
    WMCityWeather *place = [self.places objectAtIndex:indexPath.row];
    cell.name.text = place.name;
    cell.temperature.text = [NSString stringWithFormat:@"%.f˚", place.temperature];

    WMWeatherInfo *info = [place.weatherInfos lastObject];
    cell.desc.text = [NSString stringWithFormat:@"%@", info ? info.desc : @""];
    cell.humidity.text = [[NSString stringWithFormat:@"Humidity\t %.f", place.humidity] stringByAppendingString:@"%"];
    cell.pressure.text = [NSString stringWithFormat:@"Pressure\t %.f hPa", place.pressure];
    
    [self loadIconForCity:place forIndexPath:indexPath];
    
    return cell;
}

-(void) loadIconForCity:(WMCityWeather*)place forIndexPath:(NSIndexPath *)indexPath
{
    __weak WAListViewController *weakSelf = self;

    if (self.placesIcons.count > 0 && self.placesIcons[indexPath.row] == [NSNull null]) {
        WMWeatherInfo *info = [place.weatherInfos lastObject];
        NSString *icUrl = [NSString stringWithFormat:@"%@%@.png", iconUrl, info.icon];
        
        NSURLRequest *req = [NSURLRequest
                             requestWithURL:[NSURL URLWithString:icUrl]];
        
        [NSURLConnection sendAsynchronousRequest:req queue:self.iconQueue
         completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 if (!data || error) return; //do nothing or show default image
                 
                 WMWeatherCell *cell = (WMWeatherCell *)[weakSelf.tableView
                                                cellForRowAtIndexPath:indexPath];
                 UIImage *icon = [UIImage imageWithData:data];
                 
                 if (!icon) return; //do nothing or show default image
                 
                 [weakSelf.placesIcons insertObject:icon atIndex:indexPath.row];
                 cell.icon.image = weakSelf.placesIcons[indexPath.row];
             });
         }];
    }
}

-(void) didSelectedCityWithInfo:(WMCityWeather *)city
{
    for (WMCityWeather *place in self.places) {
        if ([place.name isEqualToString:city.name]) return;
    }
    
    [self.places addObject:city];
    [self.placesIcons addObject:[NSNull null]];
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WAAddCityController *addCityController = [segue destinationViewController];
    addCityController.delegate = self;
}

@end

@implementation WMWeatherCell
@end
