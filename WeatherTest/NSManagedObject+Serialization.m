//
//  NSManagedObject+Serialization.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/8/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "NSManagedObject+Serialization.h"
#import "WTAppDelegate.h"

@implementation NSManagedObject (Serialization)

- (void)populateWithDictionary:(NSDictionary *)dictionary {
    NSDictionary *attributes    = [[self entity] attributesByName];
    NSDictionary *relationShips = [[self entity] relationshipsByName];
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:attributes];
    [allParams addEntriesFromDictionary:relationShips];
    
    for (NSString *attribute in allParams) {
        id value = [dictionary objectForKey:attribute];
        
        if (value == nil) {
            continue;
        }
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            //to-one relationship
            NSRelationshipDescription* rel = [[[self entity] relationshipsByName] valueForKey:attribute];
            
            NSString* className = [[rel destinationEntity] managedObjectClassName];
            
            WTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
            
            id obj = [NSEntityDescription insertNewObjectForEntityForName:className
                                                   inManagedObjectContext:appDelegate.managedObjectContext];

            [obj populateWithDictionary:value];
            [self setValue:obj forKey:attribute];
        } else if ([value isKindOfClass:[NSArray class]]) {
            //to-many relationship
            NSMutableSet *relationShipSet = [[NSMutableSet alloc] init];
            
            NSRelationshipDescription* rel = [[[self entity] relationshipsByName] valueForKey:attribute];
            
            NSString* className = [[rel destinationEntity] managedObjectClassName];
            
            WTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
            
            for (NSDictionary *dictionary in value) {
                id obj = [NSEntityDescription insertNewObjectForEntityForName:className
                                                       inManagedObjectContext:appDelegate.managedObjectContext];
                
                [obj populateWithDictionary:dictionary];
                [relationShipSet addObject:obj];
            }
            
            [self setValue:relationShipSet forKey:attribute];
        } else {
            //attribute
            [self setValue:value forKey:attribute];
        }
    }
}

@end
