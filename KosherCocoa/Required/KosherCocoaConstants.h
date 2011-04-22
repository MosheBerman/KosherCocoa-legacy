//
//  KosherCocoaConstants.h
//  Zmanim
//
//  Created by Moshe Berman on 3/24/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//


//
//
//

#define kSettings [NSUserDefaults standardUserDefaults]

/* ------------- Latitude and Longitude Constants ------------ */

//
//  NOTE: These values are set to use stored settings value,
//  but they can be hard coded or can refer to some other value.
//
//  This is the simplest way to do though, if you want real
//  integration into your app.
//
//  For testing purposes, feel free to change the values
//  with some dummy latitude and longitude values.
//
//

#define kLatitude [[kSettings valueForKey:@"latitude"] doubleValue]

#define kLongitude [[kSettings valueForKey:@"longitude"] doubleValue]



/* ------------ Zenith constants --------------- */

#define kZenithGeometric 90.0

#define kZenithCivil 96.0

#define kZenithNautical 102.0

#define kZenithAstronomical 102.0

/* ---- Astronomical Constants --- */

#define kDegreesPerHour (360.0 / 24.0)
#define kSolarRadius (16.0/60.0)
#define kRefraction (34.0/60.0)
#define kEarthRadius 6356.9

/* ------------------------ GeoLocation Constants ----------------------- */

#define kDistance 0
#define kInitialBearing 1
#define kFinalBearing 2

/* ---------------------- Calculation Type Constants ---------------------- */

//
//  Used in the calculation methods to determine which
//  calculation we are performing. (They're essentially 
//  a boolean flag, but here it's expressed as a pair of 
//  ints.)
//

#define kTypeSunrise 0
#define kTypeSunset 1

/* --------------------- Time Constants ---------------------- */

#define kMillisecondsInAMinute 60 * 1000

#define kMillisecondsInAnHour kMillisecondsInAMinute * 60

//
//	These constants are used for determining
//	day offsets from a given date. These constants
//	make the code more readable and easier to maintain.
//

//How many seconds are in a minute (integer)
#define kSecondsInAMinute 60

//How many minutes are in an hour
#define kMinutesInAnHour 60

//how many hours are in a day
#define kHoursInADay 24

//The number of seconds in a day
#define kSecondsInADay (kSecondsInAMinute * kMinutesInAnHour * kHoursInADay)

//The number of seconds in a thirty day month
#define kSecondsInSolarYear kSecondsInADay * 365