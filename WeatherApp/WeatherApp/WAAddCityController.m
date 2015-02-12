//
//  WAAddCityController.m
//  WeatherApp
//
//  Created by Kamaldeep on 2/7/15.
//  Copyright (c) 2015 Elementum. All rights reserved.
//

#import "WAAddCityController.h"
#import <WeatherSDK/WMCurrentWeatherQuery.h>
#import <WeatherSDK/WMRequest.h>

@interface WAAddCityController ()
@property (strong, nonatomic) NSMutableDictionary *places;
@end

@implementation WAAddCityController

static NSString * const cityCellId = @"cityCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.places = [NSMutableDictionary dictionary];

    [self.searchBar becomeFirstResponder];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:cityCellId];
}


#pragma mark - UISearchBar Methods

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    __weak WAAddCityController *weakSelf = self;
    
    [self.places removeAllObjects];
    [self.tableView reloadData];
    
    if (searchText.length > 3) {
        WMCurrentWeatherQuery *params = [WMCurrentWeatherQuery
                                         weatherQueryWithCityName:searchText];
        
        [[WMRequest requestForCurrentWeather:params
                      completion:^(NSArray *result, NSError *error){
              for (WMCityWeather *city in result) {
                  weakSelf.places[city.name] = city;
              }
              [weakSelf.tableView reloadData];
        }] start];

    }
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCellId];
    WMCityWeather *place = [self.places allValues][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", place.name,
                                                                place.country];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectedCityWithInfo:)]) {
        WMCityWeather *obj = [self.places allValues][indexPath.row];
        [self.delegate didSelectedCityWithInfo:obj];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
