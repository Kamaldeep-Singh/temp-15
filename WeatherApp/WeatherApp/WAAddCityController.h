//
//  WAAddCityController.h
//  WeatherApp
//
//  Created by Kamaldeep on 2/7/15.
//  Copyright (c) 2015 Elementum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WeatherSDK/WMCityWeather.h>

@protocol WAAddCityDelegate <NSObject>
-(void) didSelectedCityWithInfo:(WMCityWeather *)city;
@end

@interface WAAddCityController : UIViewController
@property (weak, nonatomic) id<WAAddCityDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
