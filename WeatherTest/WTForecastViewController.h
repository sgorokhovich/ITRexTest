//
//  WTForecastViewController.h
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import <UIKit/UIKit.h>


@class City;


@interface WTForecastViewController : UIViewController

@property (nonatomic, strong) City *selectedCity;

@end
