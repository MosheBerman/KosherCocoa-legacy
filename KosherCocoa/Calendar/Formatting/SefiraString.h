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

/* ----------------- Sefira Formatting Constants ----------- */

//
//  If you want to allow the user to modify 
//  the visible parts of the rendered string
//  then you might map these to NSUserDefaults
//  values as is done with the latitude and longitude 
//  constants above.
//

#define kShowBracha YES

#define kShowLeshaimYichud YES

#define kShowHarachaman YES

#define kShowLamnatzaiach YES

#define kShowAna YES

#define kShowRibono YES

#define kShowAleinu YES

//
//  This alternates between nusach sefard and nusach ashkenaz
//  in the blessing over counting the omer.
//

#define kNusach YES

//
//  Used in the UI rendering classes when 
//  passed out as an HTML string. These
//  are meant to be used as CSS values.
//
//  These constants can be used to map to 
//  settings values, like NSUserDefaults. 
//

//  This is CSS "em"s
#define kLineHeight 1.5

//  This is a CSS "px" value
#define kFontSize 26

//  A string value representing
//  a font-family value

#define kFontStyle @"Helvetica"

//
//  Initialize the object with a sefira
//  day.
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
