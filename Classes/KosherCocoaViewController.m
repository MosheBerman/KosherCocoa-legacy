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
@synthesize zmanimTable;

@synthesize zmanim;

@synthesize sunriset, geoLocation, datePicker, latBox, lonBox, cl, scroller, pageControl;
@synthesize parashaLabel, nextParashaLabel ,yearInfoLabel, parashaView, suntimesView;

//
//
//

- (void)viewDidLoad{
    
    //
    // Create the location manager if this object does not
    // already have one.
    //

    if (self.cl == nil) {
        
        CLLocationManager *tempCL = [[CLLocationManager alloc] init];
        [tempCL setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        self.cl = tempCL;
        [tempCL release];
        
        self.cl.delegate = self;
        
        [self.cl startUpdatingLocation];
    }
    if (self.zmanim == nil) {
        NSMutableDictionary *t = [[NSMutableDictionary alloc] init];
        [self setZmanim:t];
        [t release];    
    }

}    

- (void)viewDidUnload{
    
    [zmanimTable release];
    zmanimTable = nil;
    
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
    
    lat = newLocation.coordinate.latitude;
    lon = newLocation.coordinate.longitude;
    alt = newLocation.altitude;
    
    //
    //  If we got all of the information that we need, 
    //  shut down Core Location and move on. If not, 
    //  use the data it did return and keep waiting for
    //  a non-zero altitude.
    //

    if (newLocation.altitude != 0.0) {
        [self goToToday:nil];
        [self.cl stopUpdatingLocation];
    }else{
        //We still don't have an altitude. Keep trying.
        [self goToToday:nil];        
    }
        
    
}

//
//  Start updating the location
//

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
    
    EarthViewer *human = [[EarthViewer alloc] initWithLatitude:lat andLongitude:lon andElevation:0.0];

    //
    //  Calculate the sunrise and sunset
    //
    
    double sunset = [human sunsetAsDoubleOnDate:[datePicker date] inTimeZone:[NSTimeZone systemTimeZone] withElevationAdjustment:NO];

    double sunrise = [human sunriseAsDoubleOnDate:[datePicker date] inTimeZone:[NSTimeZone systemTimeZone] withElevationAdjustment:NO];
	
    //
    //  Store the new times in the zmanim dictionary
    //
    
    [self.zmanim setObject:[human stringFromDate:[human dateFromTime:sunrise] forTimeZone:[NSTimeZone systemTimeZone]] forKey:@"Sunrise"];
    [self.zmanim setObject:[human stringFromDate:[human dateFromTime:sunset] forTimeZone:[NSTimeZone systemTimeZone]] forKey:@"Sunset"];      
    
    //
    //  Release the EarthViewer
    //
    
    [human release];
    
    //
    //  Reload the data
    //
    
    [zmanimTable reloadData];

}

#pragma mark - Parasha Code

- (IBAction)refreshParasha:(id)sender{
    
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [pageControl setCurrentPage:(scrollView.contentOffset.x/scrollView.frame.size.width)];
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

#pragma mark - Table Datasource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {

        //
        //  This is commented out 
        //  since Core Location does
        //  not seem to want to return
        //  an altitude, no matter
        //  how hard I try...
        //
        
        return 3;
        
        return 2;
    }else{
        return [[self.zmanim allValues] count];
    }
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"id";
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str] autorelease];
    }
    
    //
    //  Show the current latitude, longitude and altitude in thier cells
    //
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"Latitude:"];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%f", lat]];
        }else if(indexPath.row == 1){
            [cell.textLabel setText:@"Longitude:"];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%f", lon]];            
        }else if(indexPath.row == 2){
            [cell.textLabel setText:@"Altitude:"];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%f", alt]];            
        }
        
        
        
    }else if (indexPath.section == 1) {
        [cell.textLabel setText:[[zmanim allKeys] objectAtIndex:[indexPath row]]];
        [cell.detailTextLabel setText:[zmanim objectForKey:[[zmanim allKeys] objectAtIndex:[indexPath row]]]];
    }

    return cell;
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [zmanim release];
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
    [zmanimTable release];
    [zmanimTable release];
    [super dealloc];
}

@end
