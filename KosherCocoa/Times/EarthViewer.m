//
//  EarthViewer.m
//  Zmanim
//
//  Created by Moshe Berman on 3/31/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//
//  July 5, 2011 - Added warning about 
//  the deprecated method stringFromTime
//

#import "EarthViewer.h"

@implementation EarthViewer

@synthesize viewerLatitude;
@synthesize viewerLongitude;
@synthesize viewerElevation;

#pragma mark - Initializer

//
//  A custom initializer
//

- (id) initWithLatitude:(double)_lat andLongitude:(double)_lon andElevation:(double)_elev{
    
    // Initialize the Earth Viewer
    self = [super init];
    
    //  If the initialization was successful, store 
    //  the viewer's latitude and longitude.
    if(self == [super init]){
    
        [self setViewerLatitude:_lat];
        [self setViewerLongitude:_lon];
        [self setViewerElevation:_elev];
        
    }
    
    return self;
}

#pragma mark - Get Sunrise Or Sunset With Lat, Lon, Date, Elevation and optional elevation adjustment

//
//  This method returns the number of seconds since midnight 
//  at which sunrise occurs at a given location on a given 
//  date. The time is in GMT and must be adjusted for the
//  local time zone.
//
//  latitude  - This is a double representing the latitude.
//              Use a negative value for south and a positive
//              value for north.
//
//  longitude - This is a double representing the longitude.
//              Use a negative value for west and a positive
//              value for east.
//
//  date      - An NSDate object, representing the day for which
//              we are calculating sunrise and sunset.
//
//  elevation - A double representing the elevation of the 
//              target location in meters.  
//
//  withElevationAdjustment - A boolean deciding if we want to
//                            adjust for elevation.
//

- (double)sunriseAsDoubleForLatitude:(double)latitude andLongitude:(double)longitude onDate:(NSDate *)date atElevation:(double)elevation withElevationAdjustment:(BOOL)adjustforElevation{
    
    //
    //  Set up a NSTimeZone object.
    //
    //  This is actually not used in the SunriseAndSunset 
    //  implementation of calculating the times, but it was
    //  required in the original Java version, due to Java
    //  inheritance.
    //
    
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    
    //  
    //  Set up the GeoLocation object.
    //
    //  This represents the latitude and longitude used in
    //  the SunriseAndSunset object, to calculate location
    //  sensitive times for sunrise and sunset. The name
    //  argument is an artifact of the Java implementation.
    //
    //
    //
    
    GeoLocation *tempG = [[GeoLocation alloc] initWithName:@"SunViewer" andLatitude: latitude andLongitude: longitude forTimeZone:tz];
    
    //
    //  Set the elevation of the GeoLocation Object.
    //
    //  Elevation above sea level is measered in meters
    //  and affects the outcome of the calculations.
    //
    
    [tempG setElevation:elevation];
    
    //
    //  Set up the SunriseAndSunset object.
    //
    //  This object takes the GeoLocation object
    //  which we just created and uses it to do
    //  the sunrise and sunset calculations.
    //
    
    SunriseAndSunset *suntimes = [[SunriseAndSunset alloc] initWithGeoLocation:tempG];
    
    //
    //  Release the GeoLocation object.
    //
    
    [tempG release];
    
    //
    //  This next line calculates the sunrise and sunset 
    //  for a given date. We've already passed in a GeoLocation
    //  object and here we pass in an NSDate object, which 
    //  reperesents the day we are calculating sunrise and sunset
    //  on. We also pass in a value for Zenith (90.0, which gets 
    //  adjusted for civil sunrise and sunset inside of the
    //  "suntimes" instance of SunriseAndSunset.
    //
    //  We also pass in a Boolean which determines if we should
    //  adjust the values for for elevation.
    //  
    //
    
    double sunrise = [suntimes UTCSunriseForDate:date andZenith:kZenithGeometric adjustForElevation:adjustforElevation];
    
    //
    //  Release the suntimes object since we don't need it anymore.
    //
    
    [suntimes release];
	
    //
    //  Return the sunrise value
    //
    
    return sunrise;
}

//
//  This method returns the number of seconds since midnight 
//  at which sunset occurs at a given location on a given 
//  date. The time is in GMT and must be adjusted for the
//  local time zone.
//
//  latitude  - This is a double representing the latitude.
//              Use a negative value for south and a positive
//              value for north.
//
//  longitude - This is a double representing the longitude.
//              Use a negative value for west and a positive
//              value for east.
//
//  date      - An NSDate object, representing the day for which
//              we are calculating sunrise and sunset.
//
//  elevation - A double representing the elevation of the 
//              target location in meters.  
//
//  withElevationAdjustment - A boolean deciding if we want to
//                            adjust for elevation.
//

- (double)sunsetAsDoubleForLatitude:(double)latitude andLongitude:(double)longitude onDate:(NSDate *)date atElevation:(double)elevation withElevationAdjustment:(BOOL)adjustforElevation{
    
    //
    //  Set up a NSTimeZone object.
    //
    //  This is actually not used in the SunriseAndSunset 
    //  implementation of calculating the times, but it was
    //  required in the original Java version, due to Java
    //  inheritance.
    //
    
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    
    //  
    //  Set up the GeoLocation object.
    //
    //  This represents the latitude and longitude used in
    //  the SunriseAndSunset object, to calculate location
    //  sensitive times for sunrise and sunset. The name
    //  argument is an artifact of the Java implementation.
    //
    //
    //
    
    GeoLocation *tempG = [[GeoLocation alloc] initWithName:@"SunViewer" andLatitude: latitude andLongitude: longitude forTimeZone:tz];
    
    //
    //  Set the elevation of the GeoLocation Object.
    //
    //  Elevation above sea level is measered in meters
    //  and affects the outcome of the calculations.
    //
    
    [tempG setElevation:elevation];
    
    //
    //  Set up the SunriseAndSunset object.
    //
    //  This object takes the GeoLocation object
    //  which we just created and uses it to do
    //  the sunrise and sunset calculations.
    //
    
    SunriseAndSunset *suntimes = [[SunriseAndSunset alloc] initWithGeoLocation:tempG];
    
    //
    //  Release the GeoLocation object.
    //
    
    [tempG release];
    
    //
    //  This next line calculates the sunrise and sunset 
    //  for a given date. We've already passed in a GeoLocation
    //  object and here we pass in an NSDate object, which 
    //  reperesents the day we are calculating sunrise and sunset
    //  on. We also pass in a value for Zenith (90.0, which gets 
    //  adjusted for civil sunrise and sunset inside of the
    //  "suntimes" instance of SunriseAndSunset.
    //
    //  We also pass in a Boolean which determines if we should
    //  adjust the values for for elevation.
    //  
    //
    
    double sunset = [suntimes UTCSunsetForDate:date andZenith:kZenithGeometric adjustForElevation:adjustforElevation];    
        
	//
    //  Release the suntimes object since we don't need it anymore.
    //
    
    [suntimes release];
    
    //
    //  Return the sunrise value
    //
    
	
    return sunset;
}

#pragma mark - Get sunrise or sunset on Date with optional elevation adjustment

//
//  This method returns the number of seconds since midnight 
//  at which sunrise occurs at a given location on a given 
//  date. The time is in GMT and must be adjusted for the
//  local time zone.
//
//  date      - An NSDate object, representing the day for which
//              we are calculating sunrise and sunset.  
//
//  withElevationAdjustment - A boolean deciding if we want to
//                            adjust for elevation.
//

-(double) sunriseAsDoubleOnDate:(NSDate *)date withElevationAdjustment:(BOOL)adjustforElevation{
    
    return [self sunriseAsDoubleForLatitude:self.viewerLatitude andLongitude:self.viewerLongitude onDate:date atElevation:self.viewerElevation withElevationAdjustment:adjustforElevation];
    
}

//
//  This method returns the number of seconds since midnight 
//  at which sunset occurs at a given location on a given 
//  date. The time is in GMT and must be adjusted for the
//  local time zone.
//
//  date      - An NSDate object, representing the day for which
//              we are calculating sunrise and sunset.  
//
//  withElevationAdjustment - A boolean deciding if we want to
//                            adjust for elevation.
//

-(double) sunsetAsDoubleOnDate:(NSDate *)date withElevationAdjustment:(BOOL)adjustforElevation{
    
    return [self sunsetAsDoubleForLatitude:self.viewerLatitude andLongitude:self.viewerLongitude onDate:date atElevation:self.viewerElevation withElevationAdjustment:adjustforElevation];
    
}



#pragma mark - Get sunrise or sunset on Date in TimeZone with optional elevation adjustment

//
//  This method returns the number of seconds since midnight 
//  at which sunset occurs at a given location on a given 
//  date. The time is in GMT and must be adjusted for the
//  local time zone.
//
//  date      - An NSDate object, representing the day for which
//              we are calculating sunrise and sunset.  
//
//  timeZone  - A timezone object representing a time zone offset
//              from GMT.
//
//  withElevationAdjustment - A boolean deciding if we want to
//                            adjust for elevation.
//

- (double) sunriseAsDoubleOnDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone withElevationAdjustment:(BOOL)adjustforElevation{
    
    //
    //  Get the current sunset as a double
    //
    
    double sunrise = [self sunriseAsDoubleOnDate:date withElevationAdjustment:adjustforElevation];
    
    return sunrise;
    
}

//
//  This method returns the number of seconds since midnight 
//  at which sunset occurs at a given location on a given 
//  date. The time is in GMT and must be adjusted for the
//  local time zone.
//
//  date      - An NSDate object, representing the day for which
//              we are calculating sunrise and sunset.  
//
//  timeZone  - A timezone object representing a time zone offset
//              from GMT.
//
//  withElevationAdjustment - A boolean deciding if we want to
//                            adjust for elevation.
//

- (double) sunsetAsDoubleOnDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone withElevationAdjustment:(BOOL)adjustforElevation{
    
    //
    //  Get the current sunset as a double
    //
    
    double sunset = [self sunsetAsDoubleOnDate:date withElevationAdjustment:adjustforElevation];

    return sunset;
    
}

#pragma mark - NSDate from double

//
//  A method that returns the calculated time
//  as an NSDate object based on your time zone
//  and today's date
//  

- (NSDate *)dateFromTime:(double)time{
    
    return [self dateFromTime:time inTimeZone:[NSTimeZone systemTimeZone] onDate:[NSDate date]];
}

//
//  A method that returns the calculated time
//  as an NSDate object based on a given time
//  zone and a given date. 
//
//  Returns nil if the time passed in is NAN.
//  

- (NSDate *)dateFromTime:(double)time inTimeZone:(NSTimeZone *)tz onDate:(NSDate *)date{
    
    //
    //  Return nil if the time is NAN
    //
    
    if (time == NAN) {
        NSLog(@"Received an invalid number. I can't do anything with that...");
        return nil;
    }
    
    //
    //  Copy the time, so we can
    //  manipulate it later when
    //  we need to break it into
    //  an NSDateComponents object.
    //
    
    double calculatedTime = time;
    
    //
    //  Create an instance of 
    //  the Gregorian calendar.
    //
    
    NSCalendar *gregorianCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    //
    //  Convert the current time
    //  into an NSDateComponents.
    //
    
    NSDateComponents *components = [gregorianCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSEraCalendarUnit  fromDate:date];
    
    //
    //  Set the componenets time 
    //  zone to GMT, since all of
    //  our calculations were done
    //  in GMT intially.
    //
    
    [components setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    int hours = (int) calculatedTime;               // retain only the hours
    calculatedTime -= hours;
    int minutes = (int) (calculatedTime *= 60);     // retain only the minutes
    calculatedTime -= minutes;
    int seconds = (int)(calculatedTime * 60);       // retain only the seconds
    //calculatedTime -= seconds;                    // remaining milliseconds - Commented out for Build & Analyze    
    
    [components setHour: hours];
    [components setMinute:minutes];
    [components setSecond:seconds];

    //
    //  Convert the NSDateComponents
    //  to an NSDate which we will 
    //  return to the user.
    //
    
    NSDate *returnDate = [gregorianCalendar dateFromComponents:components];

    //
    //  Here we apply a time zone
    //  offset. If the time is greater
    //  than 24, or less than 0, then 
    //  we "roll" the date by a day.
    //
    //  We start by getting the 
    //  timezone offset in hours...
    //
    
    double offsetFromGMT = [tz secondsFromGMTForDate:date]/3600.0;
    
    //
    //  ... here we perform the check 
    //  then roll the date as necessary.
    //
    
    if (time + offsetFromGMT > 24) {
        returnDate = [returnDate dateByAddingTimeInterval:-kSecondsInADay];
    } else if(time + offsetFromGMT < 0){
       returnDate = [returnDate dateByAddingTimeInterval:kSecondsInADay];
    }
    
    return returnDate; 
}

#pragma mark - String from NSDate

//
//  Return a given date as 
//  a string in a given 
//  time zone.
//
//  Here we do some basic formatting
//  using the NSDateFormatter. 
//
//  Feel free to customize the behavior 
//  as you wish, to best suit your needs.
//

- (NSString *)stringFromDate:(NSDate *)date forTimeZone:(NSTimeZone *)tz{
  
    NSDateFormatter *form = [[[NSDateFormatter alloc] init] autorelease];
    [form setTimeStyle:NSDateFormatterMediumStyle];
    [form setTimeZone:tz];
    
    return [form stringFromDate:date];
    
}

#pragma mark - Determine if current time is before or after sunset

//
//  This method determines if it's currently past sunset
//

- (double) getSecondsSinceMidnight{
    
    //
    //  Create a gregorian calendar
    //
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //
    //  Create an NSDateComponents object from the current date
    //
    
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    
    //
    //  Rewind the date components back to midnight
    //
    
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    //
    //  Create an NSDate wich represents midnight
    //
    
    NSDate *midnight = [calendar dateFromComponents:components];
    
    //
    //  Get the interval between midnight
    //  and now, as a double in seconds.
    //
    
    double currentTimeInSeconds = [[NSDate date] timeIntervalSinceDate:midnight];
    
    //
    //  Release the calendar
    //
    
    [calendar release]; 
    
    //
    //  Return
    //
    
    return currentTimeInSeconds;
    
}

//
//  Takes a double representing a time, in the
//  format of HH.SSSS where HH is the number of
//  hours and .SSSS represents the fraction of 
//  an hour which is seconds and minutes.
//
//  This function assumes that adjustments for 
//  daylight savings and GMT offset were already
//  applied to the initial value.
//
//

- (double)secondsFromTime:(double)time{
    
    //
    //  Break up the initial values into
    //  hours, minutes and seconds.
    //
    
    double hours = floor(time);
    double minutes = (time - floor(time) ) * 60;
    double seconds = (minutes - floor(minutes) ) * 60;
    
    //
    //  Multiply out the hours and minutes
    //  back into thier representation as 
    //  seconds units.
    //
    
    hours = hours * 60 * 60;
    minutes = minutes * 60;
    
    //
    //  Add it all together.
    //
    
    double timeAsSeconds = hours + minutes + seconds;
    
    //
    //  Return the time as seconds
    //
    
    return timeAsSeconds;
}

//
//  Determines if sunset has ocurred yet today
//

- (BOOL)sunsetHasOccurred{

    double currentTimeAsSeconds = [self getSecondsSinceMidnight];
    
    double sunsetAsSeconds = [self secondsFromTime:[self sunsetAsDoubleOnDate:[NSDate date] inTimeZone:[NSTimeZone systemTimeZone] withElevationAdjustment:NO]];
    
    //NSLog(@"Sunset: %f, Current Time: %f", sunsetAsSeconds, currentTimeAsSeconds);
    
    if (currentTimeAsSeconds > sunsetAsSeconds) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Time as NSDate



#pragma mark - Formatting method

//
//  This method takes a time as a double
//  and returns it as a formatted string.
//

- (NSString *) timeAsStringFromDouble:(double)time{
    
#warning <WARNING:>This method is depracated. Use dateFromTime and stringFromDate instead.
    
    //
    //  If the time is greater than 12
    //  then we want to convert it to 
    //  twelve hour format and set the 
    //  AM or PM string to PM. If it's 
    //  less than twelve, make it AM.
    //  
    
    NSMutableString *AMOrPM = [[NSMutableString alloc] init];
    
    if (time > 12.0) {
        [AMOrPM setString:@"PM"];
        time = time - 12.0;
    }else{
        [AMOrPM setString:@"AM"];
    }
    
    //
    //  Get an immutable copy of the AM PM string,
    //  then release the mutable version of the string.
    //
    
    NSString *AnteOrPostMeridiem = [[AMOrPM copy] autorelease];
    [AMOrPM release];
    
    //
    //  Break up seconds into appropriate units
    //
    
    double hours = floor(time);
    double minutes = ( time - floor(time) ) * 60;
    double seconds = ( minutes - floor(minutes) ) * 60;
    
    return [NSString stringWithFormat:@"%02.0f:%02.0f:%02.0f %@", hours, minutes, seconds, AnteOrPostMeridiem];

}


@end
