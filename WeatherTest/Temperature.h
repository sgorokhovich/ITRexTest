//
//  Temperature.h
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Forecast;

@interface Temperature : NSManagedObject

@property (nonatomic, retain) NSNumber * day;
@property (nonatomic, retain) NSNumber * min;
@property (nonatomic, retain) NSNumber * max;
@property (nonatomic, retain) NSNumber * night;
@property (nonatomic, retain) NSNumber * eve;
@property (nonatomic, retain) NSNumber * morn;
@property (nonatomic, retain) Forecast *forecast;

@end
