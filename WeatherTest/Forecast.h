//
//  Forecast.h
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, Weather;

@interface Forecast : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * pressure;
@property (nonatomic, retain) NSNumber * humidity;
@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSNumber * deg;
@property (nonatomic, retain) NSNumber * clouds;
@property (nonatomic, retain) NSNumber * snow;
@property (nonatomic, retain) NSManagedObject *temperature;
@property (nonatomic, retain) Weather *weather;
@property (nonatomic, retain) City *city;

@end
