//
//  WTDetailsViewController.h
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/9/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import <UIKit/UIKit.h>


@class City;


@interface WTDetailsViewController : UIViewController

@property (strong, nonatomic) City *selectedCity;
@property (assign, nonatomic) NSInteger selectedIndex;

@end
