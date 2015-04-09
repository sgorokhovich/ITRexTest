//
//  Weather.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "Weather.h"
#import "Forecast.h"


@implementation Weather

@dynamic icon;
@dynamic id;
@dynamic main;
@dynamic weatherDescription;
@dynamic forecast;


- (WTWeatherType)weatherType {
    if ([self.main isEqualToString:@"Rain"]) {
        return WTWeatherTypeRain;
    } else if ([self.main isEqualToString:@"Clouds"]) {
        return WTWeatherTypeCloudy;
    } else if ([self.main isEqualToString:@"Snow"]) {
        return WTWeatherTypeSnow;
    }
    
    return WTWeatherTypeClear;
}

@end
