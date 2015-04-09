//
//  NSNumber+Celsium.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/9/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "NSNumber+Celsium.h"


static NSInteger const kCelsiumAbsoleteNull = 273;


@implementation NSNumber (Celsium)

- (NSInteger)celsiumTemperatureValue {
    NSInteger kelvinValue   = [self integerValue];
    NSInteger celsiumValue  = kelvinValue - kCelsiumAbsoleteNull;
    
    return celsiumValue;
}

@end
