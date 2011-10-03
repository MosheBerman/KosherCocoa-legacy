//
//  EarthViewer.h
//  Zmanim
//
//  Created by Moshe Berman on 3/31/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SunriseAndSunset.h"
#import "KosherCocoaConstants.h"

@interface EarthViewer : NSObject {
   
    double viewerLatitude;
    double viewerLongitude;
    double viewerElevation;
}

//
//  Properties for latitude,
//  longitude and elevation
//

@property double viewerLatitude;
@property double viewerLongitude;
@property double viewerElevation;

#pragma mark - 

//
//  A custom initializer that takes a latitude and longitude
//

- (id) initWithLatitude:(double)_lat andLongitude:(double)_lon andElevation:(double)_elev;

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

- (double)sunriseAsDoubleForLatitude:(double)latitude andLongitude:(double)longitude onDate:(NSDate *)date atElevation:(double)elevation withElevationAdjustment:(BOOL)adjustforElevation;
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

- (double)sunsetAsDoubleForLatitude:(double)latitude andLongitude:(double)longitude onDate:(NSDate *)date atElevation:(double)elevation withElevationAdjustment:(BOOL)adjustforElevation;

#pragma mark - Get Sunrise or Set for a given Time Zone and Date 

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

- (double) sunriseAsDoubleOnDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone withElevationAdjustment:(BOOL)adjustforElevation;

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

- (double) sunsetAsDoubleOnDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone withElevationAdjustment:(BOOL)adjustforElevation;

#pragma mark - Get Sunrise or Set for a given Date

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

- (double)sunriseAsDoubleOnDate:(NSDate *)date withElevationAdjustment:(BOOL)adjustforElevation;

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

- (double)sunsetAsDoubleOnDate:(NSDate *)date withElevationAdjustment:(BOOL)adjustforElevation;


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

- (double)secondsFromTime:(double)time;

//
//  Determines if sunset has ocurred yet today
//

- (BOOL)sunsetHasOccurred;

//
//  A method that returns the calculated time
//  as an NSDate object based on your time zone
//  and today's date
//  

- (NSDate *)dateFromTime:(double)time;

//
//  A method that returns the calculated time
//  as an NSDate object based on a given time
//  zone and a given date. 
//
//  Returns nil if the time passed in is NAN.
//  

- (NSDate *)dateFromTime:(double)time inTimeZone:(NSTimeZone *)tz onDate:(NSDate *)date;

//
//  Return a given date as 
//  a string in a given 
//  time zone.
//
//  Here we do some basic formatting
//  using the NSDateFormatter. 
//  Feel free to customize the behavior 
//  as you wish, to best suit your needs.
//
//  I think this belongs in a category...
//

- (NSString *)stringFromDate:(NSDate *)date forTimeZone:(NSTimeZone *)tz;

@end
