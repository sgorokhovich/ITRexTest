//
//  WTInboxManager.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "WTInboxManager.h"
#import "WTDataManager.h"
#import <AFNetworking/AFNetworking.h>


static NSString * const kServerURL      = @"http://api.openweathermap.org/data/2.5";
static NSString * const kImageServerURL = @"https://ssl.gstatic.com/onebox/weather/256";


@implementation WTInboxManager

#pragma mark - Shared Instance

+ (instancetype)sharedManager {
    static dispatch_once_t predicate;
    static WTInboxManager *inboxManager = nil;
    
    dispatch_once(&predicate, ^{
        inboxManager = [[WTInboxManager alloc] init];
    });
    
    return inboxManager;
}

#pragma mark - Inbox methods

- (void)getWeatherForecastForLatitude:(float)latitude
                            longitude:(float)longitude
                            daysCount:(NSInteger)daysCount
                          resultBlock:(void (^)(NSString *, NSError *))resultBlock {
    
    NSString *URLString = [NSString stringWithFormat:@"%@/forecast/daily?lat=%f&lon=%f&cnt=%ld", kServerURL,
                                                                                                 latitude,
                                                                                                 longitude,
                                                                                                 (long)daysCount];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:URLRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        WTDataManager *manager = [WTDataManager sharedManager];
        
        [manager saveCityForecastFromResponseObject:responseObject];
        
        NSString *cityName = [self responseCityName:responseObject];
        
        resultBlock(cityName, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        resultBlock(nil, error);
    }];
    
    [operation start];
}

- (void)imageForWeatherType:(WTWeatherType)weatherType
                resultBlock:(void (^)(UIImage *image, NSError *error))resultBlock; {
    NSString *URLString = [NSString stringWithFormat:@"%@%@", kImageServerURL,
                                                              [self imageServerAppendixForWeatherType:weatherType]];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:URLRequest];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIImage *image = [UIImage imageWithData:responseObject];
        
        resultBlock(image, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        resultBlock(nil, error);
    }];
    
    [operation start];
}

#pragma mark - Private

- (NSString *)responseCityName:(id)responseObject {
    NSDictionary *cityDictionary = responseObject[[WTCityKey lowercaseString]];
    
    return cityDictionary[WTCityNameKey];
}

- (NSString *)imageServerAppendixForWeatherType:(WTWeatherType)type {
    switch (type) {
        case WTWeatherTypeClear: return @"/sunny.png"; break;
        case WTWeatherTypeRain: return @"/rain.png"; break;
        case WTWeatherTypeCloudy: return @"/cloudy.png"; break;
        case WTWeatherTypeSnow: return @"/snow.png"; break;
    }
}

@end
