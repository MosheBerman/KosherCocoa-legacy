//
//  SefiraString.h
//  UltimateOmer2
//
//  Created by Moshe Berman on 3/21/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SefiraString : NSObject {
    NSInteger day;
}

@property NSInteger day;

//
//
//

- (id)initWithDay:(NSInteger)tempDay;

//
// This method returns the text for the day, with HTML formatting
//

- (NSString *)omerTextForDay:(NSInteger)tempDay;

//
//  This method returns a string in hebrew for the current day's number
//

- (NSString *)dayStringInHebrew:(NSInteger)day;

//
//  This returns a string for today's middah in hebrew
//

- (NSString *)middahStringInHebrew:(NSInteger)day;

@end
