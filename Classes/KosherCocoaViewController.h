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
#import "CalculatedZman.h"
#import "ZmanimCalendar.h"

@interface KosherCocoaViewController : UIViewController <CLLocationManagerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource> {

    //
    //  This is the object that does all the calculations
    //
    
    ZmanimCalendar *calendar;
    
    //
    //  This picker allows the user to choose a date
    //
    
    IBOutlet UIDatePicker *datePicker;
    
    //
    //  This table lists all of the information
    //
    
    UITableView *zmanimTable;
    
    //
    //
    //
    
    IBOutlet UISegmentedControl *inDiasporaSelector;
    
    //
    //  This is the CLLocationManager which 
    //  gets the user's location
    //
    
    CLLocationManager *cl;
    
    
    //
    //  This button invokes the CLLocationManager
    //
    
    UIBarButtonItem *updateLocation;
    
    //
    //  An array which holds the calculated times
    //
    
    NSMutableArray *zmanimArray;
    
    //
    //  Location variables
    //
    
    double lat;
    double lon;
    double alt;
    
}

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) CLLocationManager *cl;
@property (nonatomic, retain) NSMutableArray *zmanimArray;
@property (nonatomic, retain) IBOutlet UITableView *zmanimTable;
@property (nonatomic, retain) ZmanimCalendar *calendar;

- (IBAction)goAheadOneDay:(id)sender;
- (IBAction)goToToday:(id)sender;
- (IBAction)goBackADay:(id)sender;
- (IBAction)updateLocation:(id)sender;
- (CalculatedZman *)calculateZman:(NSString *)zman andCallIt:(NSString *)name;
- (IBAction)recalcSunTimes:(id)sender;

@end

