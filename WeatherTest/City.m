//
//  City.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "City.h"
#import "Forecast.h"
#import "Location.h"


@implementation City

@dynamic country;
@dynamic id;
@dynamic name;
@dynamic population;
@dynamic forecast;
@dynamic coord;

@dynamic updateDate;

- (NSArray *)forecastArray {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dt" ascending:YES];
    
    NSArray *forecastArray = [self.forecast sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    return forecastArray;
}

@end
