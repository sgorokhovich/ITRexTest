//
//  Location.h
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lon;
@property (nonatomic, retain) City *city;

@end
