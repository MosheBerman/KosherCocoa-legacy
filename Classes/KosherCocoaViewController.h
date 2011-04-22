//
//  ZmanimViewController.h
//  Zmanim
//
//  Created by Moshe Berman on 3/10/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SunriseAndSunset.h"

@interface KosherCocoaViewController : UIViewController <CLLocationManagerDelegate> {

    SunriseAndSunset *sunriset;
    GeoLocation *geoLocation;
    
    IBOutlet UILabel *sunriseLabel;
    IBOutlet UILabel *sunsetLabel;
    IBOutlet UILabel *latBox;
    IBOutlet UILabel *lonBox;
    IBOutlet UIDatePicker *datePicker;
    
    CLLocationManager *cl;
    UIBarButtonItem *updateLocation;
}

- (IBAction)recalcSunTimes:(id)sender;

@property (nonatomic, retain) SunriseAndSunset *sunriset;
@property (nonatomic, retain) GeoLocation *geoLocation;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UILabel*latBox;
@property (nonatomic, retain) UILabel *lonBox;
@property (nonatomic, retain) CLLocationManager *cl;

- (IBAction)goAheadOneDay:(id)sender;
- (IBAction)goToToday:(id)sender;
- (IBAction)goBackADay:(id)sender;
- (IBAction)updateLocation:(id)sender;

@end

