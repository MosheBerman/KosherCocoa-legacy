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

@interface KosherCocoaViewController : UIViewController <CLLocationManagerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource> {

    SunriseAndSunset *sunriset;
    GeoLocation *geoLocation;
    
    IBOutlet UILabel *sunriseLabel;
    IBOutlet UILabel *sunsetLabel;
    IBOutlet UILabel *latBox;
    IBOutlet UILabel *lonBox;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIScrollView *scroller;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIView *suntimesView;
    IBOutlet UIView *parashaView;    
    UITableView *zmanimTable;
    IBOutlet UILabel *parashaLabel;
    IBOutlet UILabel *nextParashaLabel;    
    IBOutlet UILabel *yearInfoLabel;
    IBOutlet UISegmentedControl *inDiasporaSelector;
    CLLocationManager *cl;
    UIBarButtonItem *updateLocation;
    NSMutableDictionary *zmanim;
    
    double lat;
    double lon;
    double alt;
    
}

- (IBAction)recalcSunTimes:(id)sender;

@property (nonatomic, retain) SunriseAndSunset *sunriset;
@property (nonatomic, retain) GeoLocation *geoLocation;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UILabel*latBox;
@property (nonatomic, retain) UILabel *lonBox;
@property (nonatomic, retain) CLLocationManager *cl;
@property (nonatomic, retain) UIScrollView *scroller;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UILabel *parashaLabel;
@property (nonatomic, retain) UILabel *nextParashaLabel;
@property (nonatomic, retain) UILabel *yearInfoLabel;
@property (nonatomic, retain) UIView *suntimesView;
@property (nonatomic, retain) UIView *parashaView;
@property (nonatomic, retain) NSMutableDictionary *zmanim;
@property (nonatomic, retain) IBOutlet UITableView *zmanimTable;

- (IBAction)goAheadOneDay:(id)sender;
- (IBAction)goToToday:(id)sender;
- (IBAction)goBackADay:(id)sender;
- (IBAction)updateLocation:(id)sender;
- (IBAction)refreshParasha:(id)sender;

@end

