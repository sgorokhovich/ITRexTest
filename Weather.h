//
//  Weather.h
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Forecast;


typedef NS_ENUM(NSInteger, WTWeatherType) {
    WTWeatherTypeRain,
    WTWeatherTypeSnow,
    WTWeatherTypeCloudy,
    WTWeatherTypeClear
};


@interface Weather : NSManagedObject

@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * main;
@property (nonatomic, retain) NSString * weatherDescription;
@property (nonatomic, retain) Forecast *forecast;


- (WTWeatherType)weatherType;

@end
