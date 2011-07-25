//
//  ZmanimViewController.m
//  Zmanim
//
//  Created by Moshe Berman on 3/10/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import "ZmanimViewController.h"
#import "EarthViewer.h"

@implementation ZmanimViewController

@synthesize sunriset, geoLocation, datePicker, latBox, lonBox, cl;

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
    
    //
    //  
    //
    
    [sunriseLabel setText:[NSString stringWithFormat:@"Sunrise: %@",[human timeAsStringFromDouble:sunrise]]];
    [sunsetLabel setText:[NSString stringWithFormat:@"Sunset: %@",[human timeAsStringFromDouble:sunset]]];    
    
    [human release];

}

#pragma mark - Wheel controls

- (IBAction)goAheadOneDay:(id)sender {
    
    [self.datePicker setDate:[NSDate dateWithTimeInterval:86400 sinceDate:[self.datePicker date]] animated:YES];
    [self recalcSunTimes:nil];    
}

- (IBAction)goToToday:(id)sender {
    [self.datePicker setDate:[NSDate date] animated:YES];
    [self recalcSunTimes:nil];
}

- (IBAction)goBackADay:(id)sender {
        [self.datePicker setDate:[NSDate dateWithTimeInterval:-86400 sinceDate:[self.datePicker date]] animated:YES];
    [self recalcSunTimes:nil];    
}


#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}



- (void)dealloc {
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
