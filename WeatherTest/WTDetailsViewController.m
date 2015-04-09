//
//  WTDetailsViewController.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/9/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "WTDetailsViewController.h"
#import "WTInboxManager.h"
#import "City.h"
#import "Forecast.h"
#import "Weather.h"
#import "Temperature.h"
#import "NSNumber+Celsium.h"


@interface WTDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

@property (weak, nonatomic) IBOutlet UILabel *dayTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *eveningTemperatureLabel;

@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *cloudinessLabel;

@end


@implementation WTDetailsViewController

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [self setupViewWithSelectedForecast];
}

#pragma mark - Private

- (void)setupViewWithSelectedForecast {
    Forecast *forecast = _selectedCity.forecastArray[_selectedIndex];
    
    _cityLabel.text = _selectedCity.name;
    
    Weather *weather = [forecast.weather.allObjects firstObject];
    _weatherLabel.text = weather.main;
    [[WTInboxManager sharedManager] imageForWeatherType:weather.weatherType
                                            resultBlock:^(UIImage *image, NSError *error) {
                                                if (!error) {
                                                    _weatherImageView.image = image;
                                                }
                                            }];
    
    Temperature *temperature = (Temperature *)forecast.temp;
    _dayTemperatureLabel.text       = [NSString stringWithFormat:@"%ld°", (long)[temperature.day celsiumTemperatureValue]];
    _nightTemperatureLabel.text     = [NSString stringWithFormat:@"%ld°", (long)[temperature.night celsiumTemperatureValue]];
    _minTemperatureLabel.text       = [NSString stringWithFormat:@"%ld°", (long)[temperature.min celsiumTemperatureValue]];
    _maxTemperatureLabel.text       = [NSString stringWithFormat:@"%ld°", (long)[temperature.max celsiumTemperatureValue]];
    _morningTemperatureLabel.text   = [NSString stringWithFormat:@"%ld°", (long)[temperature.morn celsiumTemperatureValue]];
    _eveningTemperatureLabel.text   = [NSString stringWithFormat:@"%ld°", (long)[temperature.eve celsiumTemperatureValue]];
    
    _pressureLabel.text = [forecast.pressure stringValue];
    _humidityLabel.text = [forecast.humidity stringValue];
    _windDirectionLabel.text = [forecast.deg stringValue];
    _windSpeedLabel.text = [forecast.speed stringValue];
    _cloudinessLabel.text = [forecast.clouds stringValue];
}

@end
