//
//  City.h
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Forecast, Location;

@interface City : NSManagedObject

@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * population;
@property (nonatomic, retain) NSSet *forecast;
@property (nonatomic, retain) Location *coord;
@end

@interface City (CoreDataGeneratedAccessors)

- (void)addForecastObject:(Forecast *)value;
- (void)removeForecastObject:(Forecast *)value;
- (void)addForecast:(NSSet *)values;
- (void)removeForecast:(NSSet *)values;

@end
