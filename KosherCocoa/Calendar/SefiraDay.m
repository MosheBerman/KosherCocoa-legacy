//
//  SefiraDay.m
//  UltimateOmer2
//
//  Created by Moshe Berman on 3/1/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import "SefiraDay.h"

@implementation SefiraDay
@synthesize day;

- (id) init{
	
	if(self == [super init]){
		if ([self currentDayOfOmer]) {
			self.day = [self currentDayOfOmer];
		}
	}
	
	//
	return self;
}

#pragma mark -
#pragma mark Omer Specific Utility Methods

//
//	Check if a given gregorian date is during the omer
//
//

- (BOOL) checkIfIsOmerForDate:(NSDate *)date{
    
    if ([self dayOfOmerForDate:date] != 0) {
        return YES;
    }
    
	return NO;
}


//
//	Check if a today is during the omer,
//  recalculating the current day of the
//  omer.
//
//

- (BOOL) checkIfTodayIsOmer{
    
    if ([self dayOfOmerForDate:[NSDate date]] != 0) {
        return YES;
    }
    
	return NO;
}

//
//	Check if a today is during the omer,
//  using the already calculated value
//  for today.
//
//

- (BOOL) checkIfTodayIsOmerQuick{
    
    if (self.day != 0) {
        return YES;
    }
    
	return NO;
}

//
//  This method calculates the current day of the omer from an NSDate.
//

- (NSInteger) dayOfOmerForDate:(NSDate *)date{
    
    //
    //  Adjust for Shkia here
    //
    
    GeoLocation *geoLocation = [[GeoLocation alloc] initWithName:@"User's location" andLatitude:[[[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]doubleValue] andLongitude:[[[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"]doubleValue] andElevation:0.0 andTimeZone:[NSTimeZone localTimeZone]];
    
    ZmanimCalendar *viewer = [[ZmanimCalendar alloc]initWithLocation:geoLocation];// initWithLatitude:
    
    [geoLocation release];
    
    //
    //  If sunset has occured, it's already tomorrow
    //  on the hebrew calendar. 
    //
    
    if ([[NSDate date] timeIntervalSinceDate:[viewer sunset]] > 0) {
        
        date = [date dateByAddingTimeInterval:kSecondsInADay];
        
    }
    
    [viewer release];
    
    //
	//  Determine the first day of the omer for this year
    //
    
	NSDate *firstDayOfTheOmer = [self dateOfSixteenNissanForYearOfDate:date];
    
    //
    //
    //
    
	double firstDay = [firstDayOfTheOmer timeIntervalSinceReferenceDate];
	double arbitraryDay = [date timeIntervalSinceReferenceDate];
    
    int dayOfOmer;
    
    //
    //  Calculate the day of the omer
    //
    
    dayOfOmer = (arbitraryDay/kSecondsInADay) - ((firstDay/kSecondsInADay)-1);
    
    if (dayOfOmer < 0 || dayOfOmer > 49) {
        
        dayOfOmer = 0;
    }
    
    return dayOfOmer;
    
}

- (NSInteger) currentDayOfOmer{
	
	return [self dayOfOmerForDate:[NSDate date]];
	
}

- (NSDate *) dateOfSixteenNissanForYearOfDate:(NSDate *)date{
    
	//
	//	Create the hebrew calendar
	//
	
	NSCalendar *hebrew = [[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar];
	
	//
	//	Create the unit flags to be used for the components
	//
	
	NSUInteger unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	
	//
	//	Create a new components variable which will be used to construct the hebrew date
	//
	
	NSDateComponents *hebrewComponents = [hebrew components:unitFlags fromDate:date];
	
	//
    //  Store the current hebrew year
	//
	
	NSInteger year = [hebrewComponents year];
	
	//
	//	Get the date for 16 Nissan in the current year
	//	
	
	
	//If it's a leap year, push off sefira for a month
	if ([self isHebrewLeapYear:year]) {
		[hebrewComponents setMonth:8];
	}else {
		[hebrewComponents setMonth:7];
	}

	
	[hebrewComponents setDay:16];
	[hebrewComponents setHour:0];
    [hebrewComponents setMinute:0];
    [hebrewComponents setSecond:0];
    
	NSDate *firstDayOfTheOmer = [hebrew dateFromComponents:hebrewComponents];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterLongStyle];
	[formatter setCalendar:hebrew];
	
	//NSLog(@"First Day of the Omer: %@, Formatted: %@", [firstDayOfTheOmer description], [formatter stringFromDate:firstDayOfTheOmer]);

	[formatter release];
	[hebrew release];
	
	return firstDayOfTheOmer;
}

#pragma mark -
#pragma mark Generic Utility Methods

- (BOOL) isHebrewLeapYear:(NSInteger)year{
	
	//
	//	Check if a given year is a leap year
	//
	
	return ((7 * year + 1) % 19) < 7;

}

//
//	----------
//

- (NSInteger) hebrewYearForGregorianYear:(NSInteger)year{
	
	//
	//	Create the hebrew calendar
	//
	
	NSCalendar *hebrew = [[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	//
	//	Create the unit flags to be used for the components
	//
	
	NSUInteger unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
	
	//
	//	Set up gregorian date components
	//
	
	NSDateComponents *gregorianComponents = [[NSDateComponents alloc] init];
	
	//
	//	Set the gregorian year
	//
	
	[gregorianComponents setYear:year];
	
	//
	//
	//
	
	NSDate *date = [gregorian dateFromComponents:gregorianComponents];
	
	//
	//	Create a new components variable which will be used to construct the hebrew date
	//
	
	
	NSDateComponents *hebrewComponents = [hebrew components:unitFlags fromDate:date];
	
	//
	//
	//
	
	NSInteger hebrewYear = [hebrewComponents year];
	
	//
	//	Release the calendar related object created earlier
	//
	
	[gregorianComponents release];
	[gregorian release];
	[hebrew release];
	
	return hebrewYear;
	
}

//
//	Get the current Hebrew year
//

- (NSInteger) currentHebrewYear{

	//
	//	Get the current date
	//
	
	NSDate *currentDate = [NSDate date]; 
    
	//
	//
	//
	
	NSInteger hebrewYear = [self hebrewYearForDate:currentDate];

	//	Return
	
	return hebrewYear;
	
}

//
//	Get the hebrew year for a given date
//

- (NSInteger) hebrewYearForDate:(NSDate *)date{
	
	//
	//	Create a gregorian calendar
	//
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	//
	//	Create the unit flags to be used for the components
	//
	
	NSUInteger unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
	
	//
	//	Break up the current date
	//
	
	NSDateComponents *gregorianComponents = [gregorian components:unitFlags fromDate:date];
	
	
	//
	//	Get the current year
	//
	
	NSInteger hebrewYear = [self hebrewYearForGregorianYear:[gregorianComponents year]];
	
	//
	//	Release the calendar object
	//
	
	[gregorian release];

	
	return hebrewYear;	
}

- (void)dealloc{
	[super dealloc];
}

@end
