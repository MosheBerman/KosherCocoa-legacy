//
//  WeeklyParsha.h
//  ParshaPort
//
//  Created by Moshe Berman on 1/17/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeeklyParsha : NSObject {
	NSMutableArray *parshios;
}

@property (nonatomic, strong) NSMutableArray *parshios;

//
//  Get the year type info for a given hebrew year
//

- (NSArray *) yearTypeForYear:(NSInteger)year;

//
//  Determine if a given Hebrew year is a leap year
//

- (BOOL) isHebrewLeapYear:(NSInteger)year;

//
//  Get the hebrew year for a given date
//

- (NSInteger) hebrewYearForDate:(NSDate *)date;


//
//  These two methods produce an array of parshiot for a given an array with yer information
//

- (NSMutableArray *) rearrangeParshiosForDiasporaInArray:(NSMutableArray *)mutableArray BasedOnTypeOfYear:(NSArray *)typeOfYear;

- (NSMutableArray *) rearrangeParshiosForIsraelInArray:(NSMutableArray *)mutableArray BasedOnTypeOfYear:(NSArray *)typeOfYear;

//
//  Utility functions that manipulate the original array
//

- (NSMutableArray *) addParsha:(NSString *)parsha toMutableArray:(NSMutableArray *)mutableArray;

- (NSMutableArray *) insertParsha:(NSString *)parsha intoMutableArray:(NSMutableArray *)mutableArray atIndex:(NSUInteger)index;

- (NSMutableArray *) combineParshiosFromIndex:(NSUInteger)index fromMutableArray:(NSMutableArray *)mutableArray;

//
//  Return the parsha for the weekly parsha for a given date
//

- (NSString *) thisWeeksParshaForDate:(NSDate *)date inDiaspora:(BOOL)isInDiaspora;

//
//  return the parsha for the week following a given date
//

- (NSString *) nextWeeksParshaForDate:(NSDate *)date inDiaspora:(BOOL)isInDiaspora;

//
//  Produce a string of the year type
//

- (NSString *)yearTypeStringForDate:(NSDate *)date;

@end
