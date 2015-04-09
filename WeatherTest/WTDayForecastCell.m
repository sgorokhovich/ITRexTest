//
//  WTDayForecastCell.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/9/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "WTDayForecastCell.h"
#import "Forecast.h"

@implementation WTDayForecastCell

+ (NSString *)reuseIdentifier {
    static NSString *cellID = @"WTForecastCellID";
    
    return cellID;
}

- (void)updateWithDayForecast:(Forecast *)forecast {
    self.textLabel.text = [NSString stringWithFormat:@"Forecast for %@", [forecast forecastDateString]];
}

@end
