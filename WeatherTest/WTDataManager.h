//
//  WTDatabaseManager.h
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import <Foundation/Foundation.h>


@class City;


extern NSString * const WTCityKey;
extern NSString * const WTForecastKey;
extern NSString * const WTListKey;
extern NSString * const WTCityNameKey;


@interface WTDataManager : NSObject

/**
 Initializes an `WTDataManager`.
 
 @return The newly-initialized Inbox manager
 */
+ (instancetype)sharedManager;

/**
 Saves 'City' entity with all relationships to database
 
 @param responseobject - response dictionary 
 */
- (void)saveCityForecastFromResponseObject:(id)responseObject;

/**
 Returns 'City' entity for coordinate parameters
 
 @param latitude - latitude
 @param longitude - longitude
 
 @return 'City' entity for location
 */
- (City *)cityForLatitude:(float)latitude longitude:(float)longitude;

/**
 Returns 'City' entity for city name
 
 @param name - city name
 
 @return 'City' entity for city name
 */
- (City *)cityForName:(NSString *)name;

@end
