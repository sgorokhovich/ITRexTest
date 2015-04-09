//
//  ViewController.m
//  WeatherTest
//
//  Created by Sergey Gorokhovich on 4/6/15.
//  Copyright (c) 2015 Sergey Gorokhovich. All rights reserved.
//

#import "WTMainViewController.h"
#import "WTInboxManager.h"
#import "WTDataManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "City.h"
#import "WTForecastViewController.h"


static NSInteger const kDefaultDaysCount = 10;

static NSString * const kForecastSegueID = @"WTGoToForecastID";


@interface WTMainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;

@end


@implementation WTMainViewController

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self dismissKeyboardNotifications];
}

#pragma mark - Notifications

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dismissKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [self.view setFrame:CGRectMake(0, -kbSize.height, self.view.frame.size.width, self.view.frame.size.height)];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

#pragma mark - Private

- (void)proceedToForecastScreen {
    float latitude  = _latitudeTextField.text.floatValue;
    float longitude = _longitudeTextField.text.floatValue;
    
    City *existingCity = [[WTDataManager sharedManager] cityForLatitude:latitude longitude:longitude];
    
    if (!existingCity) {
        [SVProgressHUD show];
        [[WTInboxManager sharedManager] getWeatherForecastForLatitude:latitude
                                                            longitude:longitude
                                                            daysCount:kDefaultDaysCount
                                                          resultBlock:^(NSString *cityName, NSError *error) {
                                                              [SVProgressHUD dismiss];
                                                              
                                                              if (!error) {
                                                                  City *responseCity = [[WTDataManager sharedManager] cityForName:cityName];
                                                                  [self performSegueWithIdentifier:kForecastSegueID
                                                                                            sender:responseCity];
                                                              }
                                                          }];
    } else {
        [self performSegueWithIdentifier:kForecastSegueID sender:existingCity];
    }
}

#pragma mark - Actions

- (IBAction)searchButtonTapEvent:(id)sender {
    [self endEditing];
    
    [self proceedToForecastScreen];
}

- (IBAction)endEditing {
    [self.view endEditing:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(City *)sender {
    WTForecastViewController *forecastViewController = [segue destinationViewController];
    
    forecastViewController.selectedCity = sender;
}


@end
