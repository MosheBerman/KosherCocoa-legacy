//
//  ZmanimViewController.m
//  Zmanim
//
//  Created by Moshe Berman on 3/10/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import "KosherCocoaViewController.h"
#import "EarthViewer.h"
#import "WeeklyParsha.h"

@implementation KosherCocoaViewController

@synthesize sunriset, geoLocation, datePicker, latBox, lonBox, cl, scroller, pageControl;
@synthesize parashaLabel, nextParashaLabel ,yearInfoLabel, parashaView, suntimesView;

- (void)viewDidLoad{
    
    //
    // Create the location manager if this object does not
    // already have one.
    //

    if (self.cl == nil) {
        
        CLLocationManager *tempCL = [[CLLocationManager alloc] init];
        self.cl = tempCL;
        [tempCL release];
        
        [self.cl setDesiredAccuracy:kCLLocationAccuracyBest];
        self.cl.delegate = self;
        
        [self.cl startUpdatingLocation];
    }
    
}    

- (void)viewDidUnload{
    
    [self.cl stopUpdatingLocation];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    scroller.pagingEnabled = YES;
    scroller.showsHorizontalScrollIndicator = NO;
    scroller.contentSize = CGSizeMake(scroller.frame.size.width*2, scroller.frame.size.height);

    [suntimesView setFrame:CGRectMake(0, 0, scroller.frame.size.width, scroller.frame.size.height)];
    [parashaView setFrame:CGRectMake(scroller.frame.size.width, 0, scroller.frame.size.width, scroller.frame.size.height)];
    [scroller addSubview:suntimesView];
    [scroller addSubview:parashaView];
    [pageControl setNumberOfPages:2];
    scroller.delegate = self;
}


#pragma mark - Core Location


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Failure" 
                                                    message:@"Failed to detect location." 
                                                   delegate:nil
                                          cancelButtonTitle:@"OK."
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [self.cl stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    //
    //  Show the new location info
    //
    
    self.latBox.text = [NSString stringWithFormat:@"%Lf", newLocation.coordinate.latitude];
    self.lonBox.text = [NSString stringWithFormat:@"%Lf", newLocation.coordinate.longitude];    
    
    //
    //  If we got all of the information that we need, 
    //  shut down Core Location and move on. If not, 
    //  use the data it did return and keep waiting for
    //  a non-zero altitude.
    //

    if (newLocation.altitude != 0.0) {
        [self.cl stopUpdatingLocation];
    }else{
        //We still don't have an altitude. Keep trying.
    }
        
    
}

- (IBAction)updateLocation:(id)sender {
    
    if (self.cl != nil) {
        
        [self.cl startUpdatingLocation];
        
    }
    
}

#pragma mark - Wrapper method

- (IBAction)recalcSunTimes:(id)sender{
    
    //
    //  Create the human with a given latitude and longitude
    //
    
    EarthViewer *human = [[EarthViewer alloc] initWithLatitude:[self.latBox.text doubleValue] andLongitude:[self.lonBox.text doubleValue] andElevation:0.0];

    //
    //  Calculate the sunrise and sunset
    //
    
    double sunset = [human sunsetAsDoubleOnDate:[datePicker date] inTimeZone:[NSTimeZone systemTimeZone] withElevationAdjustment:NO];

    double sunrise = [human sunriseAsDoubleOnDate:[datePicker date] inTimeZone:[NSTimeZone systemTimeZone] withElevationAdjustment:NO];
    
	NSLog(@"Sunrise: %f Sunset: %f", sunrise, sunset);
	
    //
    //  
    //
    
    [sunriseLabel setText:[NSString stringWithFormat:@"Sunrise: %@",[human timeAsStringFromDouble:sunrise]]];
    [sunsetLabel setText:[NSString stringWithFormat:@"Sunset: %@",[human timeAsStringFromDouble:sunset]]];    
    
    [human release];

}

#pragma mark - Parasha Code

- (IBAction)refreshParasha:(id)sender {
    
    WeeklyParsha *parsha = [[WeeklyParsha alloc] init];
    WeeklyParsha *nextWeekParsha = [[WeeklyParsha alloc] init];
    
    
    if ([inDiasporaSelector selectedSegmentIndex] == 0) {
        
        parashaLabel.text = [parsha thisWeeksParshaForDate:[self.datePicker date] inDiaspora:NO];
        nextParashaLabel.text = [nextWeekParsha nextWeeksParshaForDate:[datePicker date] inDiaspora:NO];
        
    }else if([inDiasporaSelector selectedSegmentIndex] == 1){
        
        parashaLabel.text = [parsha thisWeeksParshaForDate:[datePicker date] inDiaspora:YES];
        nextParashaLabel.text = [parsha nextWeeksParshaForDate:[datePicker date] inDiaspora:YES];       
    }
    
    yearInfoLabel.text = [parsha yearTypeStringForDate:[datePicker date]];
    
    [nextWeekParsha release];
    [parsha release];
    
    [inDiasporaSelector addTarget:self action:@selector(locationModeChanged:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    pageControl.currentPage = scrollView.contentSize.width/scrollView.contentOffset.x;
}

#pragma mark - Wheel controls

- (IBAction)goAheadOneDay:(id)sender {
    
    [self.datePicker setDate:[NSDate dateWithTimeInterval:86400 sinceDate:[self.datePicker date]] animated:YES];
    [self recalcSunTimes:nil]; 
    [self refreshParasha:nil];
}

- (IBAction)goToToday:(id)sender {
    [self.datePicker setDate:[NSDate date] animated:YES];
    [self recalcSunTimes:nil];
    [self refreshParasha:nil];
}

- (IBAction)goBackADay:(id)sender {
        [self.datePicker setDate:[NSDate dateWithTimeInterval:-86400 sinceDate:[self.datePicker date]] animated:YES];
    [self recalcSunTimes:nil];
    [self refreshParasha:nil];
}


#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}



- (void)dealloc {

    [yearInfoLabel release];
    [parashaLabel release];
    [nextParashaLabel release];
    [parashaView release];
    [suntimesView release];
    [scroller release];
    [cl release];
    [latBox release];
    [lonBox release];
    [datePicker release];
    [geoLocation release];
    [sunriset release];
    [updateLocation release];
    [super dealloc];
}

@end
