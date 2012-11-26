//
//  ZmanimViewController.m
//  Zmanim
//
//  Created by Moshe Berman on 3/10/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import "KosherCocoaViewController.h"
#import "WeeklyParsha.h"
#import "ZmanimCalendar.h"
#import "GeoLocation.h"

@implementation KosherCocoaViewController
@synthesize zmanimTable;

@synthesize zmanimArray;

@synthesize datePicker, cl, calendar;

//
//
//

- (void)viewDidLoad{
    
    //
    //  Set some default values
    //
    
    lat = 40.714353;
    
    lon = -74.005973;
    
    //
    // Create the location manager if this object does not
    // already have one.
    //

    if (self.cl == nil) {
        
        CLLocationManager *tempCL = [[CLLocationManager alloc] init];
        [tempCL setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        self.cl = tempCL;
        
        self.cl.delegate = self;
        
        [self.cl startUpdatingLocation];
    }
    if (self.zmanimArray == nil) {
        NSMutableArray *t = [[NSMutableArray alloc] init];
        [self setZmanimArray:t];
    }
    
    //[inDiasporaSelector addTarget:self action:@selector(locationModeChanged:) forControlEvents:UIControlEventValueChanged];    

}    

- (void)viewDidUnload{
    
    zmanimTable = nil;
    
    [self.cl stopUpdatingLocation];
}

/*
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
*/

#pragma mark - Core Location


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Failure" 
                                                    message:@"Failed to detect location." 
                                                   delegate:nil
                                          cancelButtonTitle:@"OK."
                                          otherButtonTitles:nil];
    [alert show];
    
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
        //[self goToToday:nil];        
        
        [zmanimTable reloadData];
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
    
    if (self.calendar == nil) {
        
        //
        //  Create a GeoLocation Object
        //
        //  The values here are for New York City
        //  Lat: 40.714353
        //  Lon: -74.005973
        //
        
        GeoLocation *AGeoLocation = [[GeoLocation alloc] initWithName:@"NYC" andLatitude:lat andLongitude:lon andTimeZone:[NSTimeZone systemTimeZone]];
        
        //
        //  Create a Zmanim Calendar
        //
        
        ZmanimCalendar *zmanimCalendar = [[ZmanimCalendar alloc] initWithLocation:AGeoLocation];
        
        
        self.calendar = zmanimCalendar;
        
        
    }
    
    //
    //  Set the date to the working date
    //
    
    [self.calendar setWorkingDate:[datePicker date]];
    
    
    [self.zmanimArray removeAllObjects];

    [self.zmanimArray addObject:[self calculateZman:@"alosHashachar" andCallIt:@"Alos (16.1 deg)"]];
    [self.zmanimArray addObject:[self calculateZman:@"alos72" andCallIt:@"Alos (72 min)"]];    
    [self.zmanimArray addObject:[self calculateZman:@"sunrise" andCallIt:@"Sunrise"]];
    [self.zmanimArray addObject:[self calculateZman:@"sofZmanShmaMogenAvraham" andCallIt:@"Shma (M.A.)"]];        
    [self.zmanimArray addObject:[self calculateZman:@"sofZmanShmaGra" andCallIt:@"Shma (Gra)"]];
    [self.zmanimArray addObject:[self calculateZman:@"sofZmanTfilaMogenAvraham" andCallIt:@"Tfila (M.A.)"]];        
    [self.zmanimArray addObject:[self calculateZman:@"sofZmanTfilaGra" andCallIt:@"Tfila (Gra)"]];            
    [self.zmanimArray addObject:[self calculateZman:@"chatzos" andCallIt:@"Chatzos"]]; 
    [self.zmanimArray addObject:[self calculateZman:@"minchaGedola" andCallIt:@"Mincha Gedola"]];     
    [self.zmanimArray addObject:[self calculateZman:@"minchaKetana" andCallIt:@"Mincha Ketana"]];         
    [self.zmanimArray addObject:[self calculateZman:@"plagHamincha" andCallIt:@"Plag HaMincha"]];             
    [self.zmanimArray addObject:[self calculateZman:@"sunset" andCallIt:@"Sunset"]];    
    [self.zmanimArray addObject:[self calculateZman:@"tzais" andCallIt:@"Tzais (8.5 deg)"]];         
    [self.zmanimArray addObject:[self calculateZman:@"tzais72" andCallIt:@"Tzais (72 min)"]];             
    
    //
    //  Reload the data
    //
    
    [zmanimTable reloadData];

}

- (CalculatedZman *)calculateZman:(NSString *)zman andCallIt:(NSString *)name{

    CalculatedZman *calcZman = [[CalculatedZman alloc] init];
    calcZman.name = name;
    
    //
    //  If a real selector was passed in, use it.
    //
    
    if ([self.calendar respondsToSelector:NSSelectorFromString(zman)]) {
        
        calcZman.time = [self.calendar stringFromDate:[self.calendar performSelector:NSSelectorFromString(zman)] forTimeZone:self.calendar.geoLocation.timeZone];
    }
    
    return calcZman;    
}

#pragma mark - Parasha Code

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

#pragma mark - Table Datasource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {

        //
        //  Core Location does not
        //  seem to want to return
        //  an altitude, no matter
        //  how hard I try...
        //
        
        return 3;
        
    }else if (section == 0){
        return [self.zmanimArray count];
    }else if (section == 1){
        return 2;//parasha israel and diaspora
    }
    
    return 1;
}

//
//  We now have three sections -
//
//  One for basic zmanim, one for the
//  parasha, and one for location information.
//
//

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"id";
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    
    //
    //  Show the current latitude, longitude and altitude in thier cells
    //
    
    if (indexPath.section == 2) {
        
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
        
        
        
    }else if (indexPath.section == 0) {
        

        [cell.textLabel setText:((CalculatedZman *)[zmanimArray objectAtIndex:[indexPath row]]).name];
        [cell.detailTextLabel setText:((CalculatedZman *)[zmanimArray objectAtIndex:[indexPath row]]).time];
        
    }else if (indexPath.section == 1){

        WeeklyParsha *parsha = [[WeeklyParsha alloc] init];
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = @"Parasha (Diaspora)";
            cell.detailTextLabel.text = [parsha thisWeeksParshaForDate:[datePicker date] inDiaspora:YES];
            

        }else if(indexPath.row == 1){
            cell.textLabel.text = @"Parasha (Israel)";
            cell.detailTextLabel.text = [parsha thisWeeksParshaForDate:[datePicker date] inDiaspora:NO];
        }
        
    }

    return cell;
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


@end
