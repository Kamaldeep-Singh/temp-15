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
@end

@interface WAListViewController () <WAAddCityDelegate>
@property (strong, nonatomic) NSMutableArray *places;
@end

@implementation WAListViewController

static NSString * const cellId = @"WeatherCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WeatherCell" bundle:nil]
         forCellReuseIdentifier:cellId];
    self.tableView.sectionFooterHeight = 64.0;
    
    self.places = [NSMutableArray array];
    
    //  Default entry
    WMCityWeather *currentLocation = [[WMCityWeather alloc]
                            initWithDictionary:@{@"name":@"Current Location",
                                                 @"main":@{@"temperature":@""}}];
    [self.places addObject:currentLocation];

    [self updateWeatherForCurrentLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateWeatherForCurrentLocation
{
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
               weakSelf.places[0] = [result lastObject];
               [weakSelf.tableView reloadData];
         }] start];
     }];
}

#pragma mark - UITableView Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    WAAddCityController *addCityController = [storyBoard instantiateViewControllerWithIdentifier:@"WAAddCityController"];
//    fullVC.photo = self.photos[indexPath];
//    UINavigationController *navVC = self.navigationController;
//    [navVC pushViewController:fullVC animated:YES];
}

-(void) didSelectedCityWithInfo:(WMCityWeather *)city
{
    [self.places addObject:city];
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
