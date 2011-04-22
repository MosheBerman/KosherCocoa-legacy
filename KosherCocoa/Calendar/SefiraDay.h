//
//  SefiraDay.h
//  UltimateOmer2
//
//  Created by Moshe Berman on 3/1/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EarthViewer.h"

@interface SefiraDay : NSObject {

	NSInteger day;
    
}

@property (nonatomic) NSInteger day;

#pragma mark -
#pragma mark Omer Specific Utility Methods

- (BOOL) checkIfIsOmerForDate:(NSDate *)date;

- (NSDate *) dateOfSixteenNissanForYearOfDate:(NSDate *)date;

- (NSInteger) dayOfOmerForDate:(NSDate *)date;

- (NSInteger) getCurrentDayOfOmer;

#pragma mark -
#pragma mark Generic Utility Methods

- (BOOL) isHebrewLeapYear:(NSInteger)year;

- (NSInteger) hebrewYearForGregorianYear:(NSInteger)Year;

- (NSInteger) getCurrentHebrewYear;

- (NSInteger) hebrewYearForDate:(NSDate *)date;

@end
