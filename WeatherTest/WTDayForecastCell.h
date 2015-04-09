//
//  WTDayForecastCell.h
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/9/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Forecast;


@interface WTDayForecastCell : UITableViewCell

+ (NSString *)reuseIdentifier;

- (void)updateWithDayForecast:(Forecast *)forecast;

@end
