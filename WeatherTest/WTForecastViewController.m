//
//  WTForecastViewController.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "WTForecastViewController.h"
#import "WTDetailsViewController.h"
#import "WTDayForecastCell.h"
#import "City.h"


static NSString * const kDetailsSegueID = @"WTGoToDetailsID";


@interface WTForecastViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end


@implementation WTForecastViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _selectedCity.forecastArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTDayForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:[WTDayForecastCell reuseIdentifier]];
    
    [cell updateWithDayForecast:_selectedCity.forecastArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kDetailsSegueID sender:indexPath];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)indexPath {
    WTDetailsViewController *detailsViewController = segue.destinationViewController;
    
    detailsViewController.selectedCity  = _selectedCity;
    detailsViewController.selectedIndex = indexPath.row;
}


@end
