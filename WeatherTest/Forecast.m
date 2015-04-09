//
//  Forecast.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "Forecast.h"
#import "City.h"
#import "Weather.h"


@implementation Forecast

@dynamic dt;
@dynamic pressure;
@dynamic humidity;
@dynamic speed;
@dynamic deg;
@dynamic clouds;
@dynamic snow;
@dynamic temp;
@dynamic weather;
@dynamic city;

- (NSDate *)forecastDate {
    double timeStamp = self.dt.doubleValue;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    return date;
}

- (NSString *)forecastDateString {
    NSDate *forecastDate = [self forecastDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM"];
    
    NSString *stringFromDate = [dateFormatter stringFromDate:forecastDate];
    
    return stringFromDate;
}

@end
