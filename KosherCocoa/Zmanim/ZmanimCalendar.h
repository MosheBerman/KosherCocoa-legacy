//
//  ZmanimCalendar.h
//  KosherCocoa
//
//  Created by Moshe Berman on 7/19/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AstronomicalCalendar.h"

@interface ZmanimCalendar :  AstronomicalCalendar{
    
}

@property (nonatomic) NSInteger candleLightingOffset;

- (NSDate *) alosHashachar;

- (NSDate *) alos72;

- (NSDate *) chatzos;

- (NSDate *) sofZmanShmaGra;

- (NSDate *) sofZmanShmaMogenAvraham;

- (NSDate *) candleLighting;

- (NSDate *) sofZmanTfilaGra;

- (NSDate *) sofZmanTfilaMogenAvraham;

- (NSDate *) minchaGedola;

- (NSDate *) minchaKetana;

- (NSDate *) plagHamincha;

- (NSDate *)tzais;

- (NSDate *) tzais72;

- (double) shaaZmanisGra;

- (double) shaahZmanisMogenAvraham;

@end
