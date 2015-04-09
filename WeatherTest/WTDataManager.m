//
//  WTDatabaseManager.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "WTAppDelegate.h"
#import "WTDataManager.h"
#import "City.h"
#import "Forecast.h"
#import "NSManagedObject+Serialization.h"


NSString * const WTCityKey     = @"City";
NSString * const WTForecastKey = @"Forecast";
NSString * const WTListKey     = @"list";
NSString * const WTCityNameKey = @"name";


static NSInteger const kUpdateCityForecastDelta = 10;


@implementation WTDataManager

#pragma mark - Shared Instance

+ (instancetype)sharedManager {
    static dispatch_once_t predicate;
    static WTDataManager *databaseManager = nil;
    
    dispatch_once(&predicate, ^{
        databaseManager = [[WTDataManager alloc] init];
    });
    
    return databaseManager;
}

#pragma mark - DB methods

- (void)saveCityForecastFromResponseObject:(id)responseObject {
    WTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    NSDictionary *cityObject = responseObject[[WTCityKey lowercaseString]];
    
    City *city = [NSEntityDescription insertNewObjectForEntityForName:WTCityKey
                                               inManagedObjectContext:appDelegate.managedObjectContext];
    [city populateWithDictionary:cityObject];
    city.updateDate = [NSDate date];
    
    //Connect forecast block as a relationship
    NSDictionary *forecastDictionary = responseObject[WTListKey];
    
    for (NSDictionary *list in forecastDictionary) {
        Forecast *forecast = [NSEntityDescription insertNewObjectForEntityForName:WTForecastKey
                                                           inManagedObjectContext:appDelegate.managedObjectContext];
        [forecast populateWithDictionary:list];
        
        [city addForecastObject:forecast];
    }
    
    [appDelegate saveContext];
}

- (City *)cityForLatitude:(float)latitude longitude:(float)longitude {
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:WTCityKey
                                                         inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(coord.lat == %f) AND (coord.lon == %f)", latitude, longitude];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    if (!error) {
        if (array != nil) {
            return [array firstObject];
        }
    }
    
    return nil;
}

- (City *)cityForName:(NSString *)name {
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:WTCityKey
                                                         inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    if (!error) {
        if (array != nil) {
            City *city = [array firstObject];
            
            return (![self isNeedsToUpdate:city]) ? city : nil;
        }
    }
    
    return nil;
}

#pragma mark - Private

- (BOOL)isNeedsToUpdate:(City *)city {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                               fromDate:city.updateDate
                                                 toDate:[NSDate date]
                                                options:0];
    
    return (components.day > kUpdateCityForecastDelta);
}

- (NSManagedObjectContext *)managedObjectContext {
    WTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    return appDelegate.managedObjectContext;
}

@end
