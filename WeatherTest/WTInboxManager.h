//
//  WTInboxManager.h
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Weather.h"


@interface WTInboxManager : NSObject

/**
 Initializes an `WTInboxManager`.
 
 @return The newly-initialized Inbox manager
 */
+ (instancetype)sharedManager;


/**
 Getting weather forecast
 
 @param latitude  - location latitude
 @param longitude - location longitude
 @param daysCount - forecast days count
 @resultBlock     - A block object to be executed when the task finishes. This block returns a array of forecasts and  NSError object or nil, in case of successful request.
*/
- (void)getWeatherForecastForLatitude:(float)latitude
                            longitude:(float)longitude
                            daysCount:(NSInteger)daysCount
                          resultBlock:(void (^)(NSString *cityName, NSError *error))resultBlock;

/**
 Getting weather icon depends on weather type
 
 @param weatherType - WTWeatherType enum value
 */
- (void)imageForWeatherType:(WTWeatherType)weatherType
                resultBlock:(void (^)(UIImage *image, NSError *error))resultBlock;

@end
