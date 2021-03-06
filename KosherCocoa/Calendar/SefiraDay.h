//
//  SefiraDay.h
//  UltimateOmer2
//
//  Created by Moshe Berman on 3/1/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeoLocation.h"
#import "ZmanimCalendar.h"

@interface SefiraDay : NSObject {

	NSInteger day;
    
}

@property (nonatomic) NSInteger day;

#pragma mark -
#pragma mark Omer Specific Utility Methods

- (BOOL) checkIfIsOmerForDate:(NSDate *)date;

- (NSDate *) dateOfSixteenNissanForYearOfDate:(NSDate *)date;

- (NSInteger) dayOfOmerForDate:(NSDate *)date;

- (NSInteger) currentDayOfOmer;

#pragma mark -
#pragma mark Generic Utility Methods

- (BOOL) isHebrewLeapYear:(NSInteger)year;

- (NSInteger) hebrewYearForGregorianYear:(NSInteger)Year;

- (NSInteger) currentHebrewYear;

- (NSInteger) hebrewYearForDate:(NSDate *)date;

@end
