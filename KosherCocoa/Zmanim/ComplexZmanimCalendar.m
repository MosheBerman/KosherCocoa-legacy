//
//  ComplexZmanimCalendar.m
//  KosherCocoa
//
//  Created by Moshe Berman on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ComplexZmanimCalendar.h"

@implementation ComplexZmanimCalendar
@synthesize ateretTorahSunsetOffset;

- (id)init
{
    self = [super init];
    if (self) {
        
        //In Israel, this value should be set to 25
        ateretTorahSunsetOffset = 40;
    }
    
    return self;
}

- (long) shaahZmanis19Point8Degrees{
    return [self temporalHourFromSunrise:[self alos19Point8Degrees] toSunset:[self tzais19Point8Degrees]];
}

- (long) shaahZmanis18Degrees{
    return [self temporalHourFromSunrise:[self alos18Degrees] toSunset:[self tzais18Degrees]];
}

- (long) shaahZmanis26Degrees{
    return [self temporalHourFromSunrise:[self alos26Degrees] toSunset:[self tzais26Degrees]];
}

- (long) shaahZmanis16Point1Degrees{
    return [self temporalHourFromSunrise:[self alos16Point1Degrees] toSunset:[self tzais16Point1Degrees]];
}

- (long) shaahZmanis60Minutes{
    return [self temporalHourFromSunrise:[self alos60] toSunset:[self tzais60]];
}

- (long) shaahZmanis72Minutes{
    return [self shaahZmanisMogenAvraham];
}

- (long) shaahZmanis72MinutesZmanis{
    return [self temporalHourFromSunrise:[self alos72Zmanis] toSunset:[self tzais72Zmanis]];
}

- (long) shaahZmanis90Minutes{
    return [self temporalHourFromSunrise:[self alos90] toSunset:[self tzais90]];
}

- (long) shaahZmanis90MinutesZmanis{
    return [self temporalHourFromSunrise:[self alos90Zmanis] toSunset:[self tzais90Zmanis]];
}

- (long) shaahZmanis96Minutes{
    return [self temporalHourFromSunrise:[self alos96] toSunset:[self tzais96]];
}

- (long) shaahZmanis96MinutesZmanis{
    return [self temporalHourFromSunrise:[self alos96Zmanis] toSunset:[self tzais96Zmanis]];
}

- (long) shaahZmanisAteretTorah{
    return [self temporalHourFromSunrise:[self alos72Zmanis] toSunset:[self tzaisAteretTorah]];
}

- (long) shaahZmanis120Minutes{
    return [self temporalHourFromSunrise:[self alos120] toSunset:[self tzais120]];
}

- (long) shaahZmanis120MinutesZmanis{
    return [self temporalHourFromSunrise:[self alos120Zmanis] toSunset:[self tzais120Zmanis]];
}

- (NSDate *) plagHamincha120Minutes{
    return [[self alos120Zmanis] dateByAddingTimeInterval:[self shaahZmanis120Minutes]*10.75];
}

- (NSDate *) plagHamincha120MinutesZmanis{
    return [[self alos120Zmanis] dateByAddingTimeInterval:[self shaahZmanis120MinutesZmanis]*10.75];
}

- (NSDate *) alos60{
    return [[self seaLevelSunrise] dateByAddingTimeInterval:-60*kSecondsInAMinute];
}

//
//  Return nil if we can't compute, like the arctic circle
//

- (NSDate *) alos72Zmanis{
    long shaahZmanis = [self shaahZmanisGra];
    
    if (shaahZmanis == LONG_MIN) {
        return nil;
    }
    
    return [[self seaLevelSunrise] dateByAddingTimeInterval:shaahZmanis*-1.2];
}

- (NSDate *) alos90{
    return  [[self seaLevelSunrise] dateByAddingTimeInterval:-90 * kSecondsInAMinute];
}

- (NSDate *) alos90Zmanis{
    long shaahZmanis = [self shaahZmanisGra];
    
    if (shaahZmanis == LONG_MIN) {
        return nil;
    }
    
    return [[self seaLevelSunrise] dateByAddingTimeInterval:(shaahZmanis * -1.5)];
}

- (NSDate *) alos96{
    return [[self seaLevelSunrise] dateByAddingTimeInterval:-96 * kSecondsInAMinute ];
}

- (NSDate *) alos96Zmanis{

    long shaahZmanis = [self shaahZmanisGra];
    
    if (shaahZmanis == LONG_MIN) {
        return nil;
    }
    
    return [[self seaLevelSunrise] dateByAddingTimeInterval:shaahZmanis * -1.6];
}

- (NSDate *) alos120{
    
    return [[self seaLevelSunrise] dateByAddingTimeInterval:-120 * kSecondsInAMinute];

}

- (NSDate *) alos120Zmanis{
    long shaahZmanis = [self shaahZmanisGra];
    
    if (shaahZmanis == LONG_MIN) {
        return nil;
    }
    
    return [[self seaLevelSunrise] dateByAddingTimeInterval:shaahZmanis * -2];
}

- (NSDate *) alos26Degrees{
    return [self sunriseOffsetByDegrees:kZenithTwentySix];
}

- (NSDate *) alos18Degrees{
    return [self sunriseOffsetByDegrees:kZenithAstronomical];
}

- (NSDate *) alos19Point8Degrees{
    return [self sunriseOffsetByDegrees:kZenithNineteenPointEight];
}

- (NSDate *) alos16Point1Degrees{
    return [self sunriseOffsetByDegrees:kZenithSixteenPointOne];
}

- (NSDate *) misheyakir11Point5Degrees{
    return [self sunriseOffsetByDegrees:kZenithElevenPointFive];
}

- (NSDate *) misheyakir11Degrees{
    return [self sunriseOffsetByDegrees:kZenithElevenDegrees];
}

- (NSDate *) misheyakir10Point2Degrees{
    return [self sunriseOffsetByDegrees:kZenithTenPointTwo];
}

- (NSDate *) sofZmanShmaMGA19Point8Degrees{
    return [[self sunriseOffsetByDegrees:kZenithNineteenPointEight] dateByAddingTimeInterval:[self shaahZmanis19Point8Degrees]*3];
}

- (NSDate *) sofZmanShmaMGA16Point1Degrees{
    return [[self alos16Point1Degrees] dateByAddingTimeInterval:[self shaahZmanis16Point1Degrees] *3];
}

- (NSDate *) sofZmanShmaMGA72Minutes{
    return [self sofZmanShmaMogenAvraham];
}

- (NSDate *) sofZmanShmaMGA72MinutesZmanis{
    return [[self alos72Zmanis] dateByAddingTimeInterval:[self shaahZmanis72MinutesZmanis]*3];
}

- (NSDate *) sofZmanShmaMGA90Minutes{
    return [[self alos90] dateByAddingTimeInterval:[self shaahZmanis90Minutes]*3];
}

- (NSDate *) sofZmanShmaMGA90MinutesZmanis{
    return [[self alos90Zmanis] dateByAddingTimeInterval:[self shaahZmanis90MinutesZmanis]*3];
}

- (NSDate *) sofZmanShmaMGA96Minutes{
    return [[self alos96] dateByAddingTimeInterval:[self shaahZmanis96Minutes]*3];
}

- (NSDate *) sofZmanShmaMGA96MinutesZmanis{
    return [[self alos96Zmanis] dateByAddingTimeInterval:[self shaahZmanis96MinutesZmanis] *3];
}

- (NSDate *) sofZmanShma3HoursBeforeChatzos{
    return [[self chatzos] dateByAddingTimeInterval:-180 * kSecondsInAMinute];
}

- (NSDate *) sofZmanShmaMGA120Minutes{
    return [[self alos120] dateByAddingTimeInterval:[self shaahZmanis120Minutes]*3];
}

- (NSDate *) sofZmanShmaAlos16Point1ToSunset{
    long shaahZmanis = [self temporalHourFromSunrise:[self alos16Point1Degrees] toSunset:[self seaLevelSunset]];
    /*
    if (shaahZmanis == LONG_MIN) {
        return nil;
    }
    */
    return [[self alos16Point1Degrees] dateByAddingTimeInterval:shaahZmanis*3];
}

- (NSDate *) sofZmanShmaAlos16Point1ToTzaisGeonim7Point083Degrees{
    long shaahZmanis = [self temporalHourFromSunrise:[self alos16Point1Degrees] toSunset:[self tzaisGeonim7Point083Degrees]];
    /*
     if (shaahZmanis == LONG_MIN) {
        return nil;
     }     
     */
    return [[self alos16Point1Degrees] dateByAddingTimeInterval:shaahZmanis * 3];
                        
}

//
//  TODO: Verify that this is accurate
//

- (NSDate *) sofZmanShmaKolEliyahu{
    NSDate *chatzos = [self fixedLocalChatzos];
    
    if (chatzos == nil || [self sunrise] == nil) {
        return nil;
    }
    
    long diff = ([chatzos timeIntervalSince1970] - [[self seaLevelSunset] timeIntervalSince1970])/2;
    
    return [chatzos dateByAddingTimeInterval:-diff];
}


- (NSDate *) sofZmanTfilaMGA19Point8Degrees{
    return [[self alos19Point8Degrees] dateByAddingTimeInterval:[self shaahZmanis19Point8Degrees]*4];
}

- (NSDate *) sofZmanTfilaMGA16Point1Degrees{
    return [[self alos16Point1Degrees] dateByAddingTimeInterval:[self shaahZmanis16Point1Degrees]*4];
}

- (NSDate *) sofZmanTfilaMGA72Minutes{
    return [self sofZmanTfilaMogenAvraham];
}

- (NSDate *) sofZmanTfilaMGA72MinutesZmanis{
    return [[self alos72Zmanis] dateByAddingTimeInterval:[self shaahZmanis72MinutesZmanis] *4];
}

- (NSDate *) sofZmanTfilaMGA90Minutes{
    return [[self alos90] dateByAddingTimeInterval:[self shaahZmanis90Minutes]*4];
}

- (NSDate *) sofZmanTfilaMGA90MinutesZmanis{
    return [[self alos90Zmanis] dateByAddingTimeInterval:[self shaahZmanis90MinutesZmanis]*4];
}

- (NSDate *) sofZmanTfilaMGA96Minutes{
    return [[self alos96] dateByAddingTimeInterval:[self shaahZmanis96Minutes] *4];
}

- (NSDate *) sofZmanTfilaMGA96MinutesZmanis{
    return [[self alos96Zmanis] dateByAddingTimeInterval:[self shaahZmanis96MinutesZmanis] *4];
}

- (NSDate *) sofZmanTfilaMGA120Minutes{
    return [[self alos120] dateByAddingTimeInterval:[self shaahZmanis120Minutes] *4];
}

- (NSDate *) sofZmanTfila2HoursBeforeChatzos{
    return [[self chatzos] dateByAddingTimeInterval:-120 * kSecondsInAMinute];
}

- (NSDate *) minchaGedola30Minutes{

    return [[self chatzos] dateByAddingTimeInterval:kSecondsInAMinute * 30];
    
} //30 minutes after chatzos

- (NSDate *) minchaGedola72Minutes{
    return [[self alos72] dateByAddingTimeInterval:[self shaahZmanis72Minutes]*6.5];
}

- (NSDate *) minchaGedola16Point1Degrees{
    return [[self alos16Point1Degrees]dateByAddingTimeInterval:[self shaahZmanis16Point1Degrees]*6.5];
}

- (NSDate *) minchaGedolaGreaterThan30{
    if ([self minchaGedola30Minutes] == nil || [self minchaGedola] == nil) {
        return nil;
    }
    
    if ([self minchaGedola] > 0) {
        return [self minchaGedola30Minutes];
    }else{
        return [self minchaGedola];
    }
    
}

- (NSDate *) minchaKetana16Point1Degrees{
    return [[self alos16Point1Degrees] dateByAddingTimeInterval:[self shaahZmanis16Point1Degrees] * 9.5];
}

- (NSDate *) minchaKetana72Minutes{
    return [[self alos72] dateByAddingTimeInterval:[self shaahZmanis72MinutesZmanis]*9.5];
}

- (NSDate *) plagHamincha60Minutes{
    return [[self alos60] dateByAddingTimeInterval:[self shaahZmanis60Minutes] * 10.75];
}

- (NSDate *) plagHamincha72Minutes{
    return [[self alos72] dateByAddingTimeInterval:[self shaahZmanis72Minutes] * 10.75];
}

- (NSDate *) plagHamincha90Minutes{
    return [[self alos90] dateByAddingTimeInterval:[self shaahZmanis90Minutes] * 10.75];
}

- (NSDate *) plagHamincha96Minutes{
    return [[self alos96] dateByAddingTimeInterval:[self shaahZmanis96Minutes] * 10.75];
}

//
//  TODO: Reorder these to follow the logical pairing
//

- (NSDate *) plagHamincha96MinutesZmanis{
    return [[self alos96Zmanis] dateByAddingTimeInterval:[self shaahZmanis96MinutesZmanis] * 10.75];
}

- (NSDate *) plagHamincha90MinutesZmanis{
    return [[self alos90Zmanis] dateByAddingTimeInterval:[self shaahZmanis90MinutesZmanis] * 10.75];
}

- (NSDate *) plagHamincha72MinutesZmanis{
    return [[self alos72Zmanis] dateByAddingTimeInterval:[self shaahZmanis72MinutesZmanis] * 10.75];
}

- (NSDate *) plagHamincha16Point1Degrees{
    return [[self alos16Point1Degrees] dateByAddingTimeInterval:[self shaahZmanis16Point1Degrees] * 10.75];
}

- (NSDate *) plagHamincha19Point8Degrees{
    return [[self alos19Point8Degrees] dateByAddingTimeInterval:[self shaahZmanis19Point8Degrees] * 10.75];
}

- (NSDate *) plagHamincha26Degrees{
    return [[self alos26Degrees] dateByAddingTimeInterval:[self shaahZmanis26Degrees] * 10.75];
}

- (NSDate *) plagHamincha18Degrees{
    return [[self alos18Degrees] dateByAddingTimeInterval:[self shaahZmanis18Degrees] * 10.75];
}

- (NSDate *) plagAlosToSunset{
    long shaaZmanis = [self temporalHourFromSunrise:[self alos16Point1Degrees] toSunset:[self seaLevelSunset]];
    return [[self alos16Point1Degrees] dateByAddingTimeInterval:shaaZmanis*10.75];
}

- (NSDate *) plagAlos16Point1ToTzaisGeonim7Point083Degrees{
    long shaahZmanis = [self temporalHourFromSunrise:[self alos16Point1Degrees] toSunset:[self tzaisGeonim7Point083Degrees]];
    return [[self alos16Point1Degrees] dateByAddingTimeInterval:shaahZmanis * 10.75];
}

- (NSDate *) bainHashmashosRT13Degrees{
    return [self sunsetOffsetByDegrees:kZenithThirteenPointTwentyFourDegrees];
}

- (NSDate *) bainHashmashosRT58Point5Minutes{
    return [[self seaLevelSunset] dateByAddingTimeInterval:58.5 * kSecondsInAMinute];
}

- (NSDate *) bainHashmashosRT13Point5MinutesBefore7Point083Degrees{
    return [[self sunsetOffsetByDegrees:kZenithSevenPointZeroEightThree] dateByAddingTimeInterval:-13.5 * kSecondsInAMinute];
}

- (NSDate *) bainHashmashosRT2Stars{
    NSDate *alos19Point8 = [self alos19Point8Degrees];
    NSDate *sunrise = [self seaLevelSunrise];
    
    if (alos19Point8 == nil || sunrise == nil) {
        return nil;
    }

        //TODO: Check that the 18 doesn't need a d at the end
    return [[self seaLevelSunrise] dateByAddingTimeInterval:([sunrise timeIntervalSinceReferenceDate]-[[self alos19Point8Degrees]timeIntervalSinceReferenceDate])*(5/18)];
}

- (NSDate *) tzaisGeonim5Point95Degrees{
    return [self sunsetOffsetByDegrees:kZenithFivePointNinetyFive];
}

- (NSDate *) tzaisGeonim3Point65Degrees{
    return [self sunsetOffsetByDegrees:kZenithThreePointSixtyFive];
}

- (NSDate *) tzaisGeonim4Point61Degrees{
    return [self sunsetOffsetByDegrees:kZenithFourPointSixtyOne];
}

- (NSDate *) tzaisGeonim4Point37Degrees{
    return [self sunsetOffsetByDegrees:kZenithFourPointThirtySeven];
}

- (NSDate *) tzaisGeonim5Point88Degrees{
    return [self sunsetOffsetByDegrees:kZenithFivePointEightyEight];
}

- (NSDate *) tzaisGeonim4Point8Degrees{
    return [self sunsetOffsetByDegrees:kZenithFourPointEight];
}

- (NSDate *) tzaisGeonim7Point083Degrees{
    return [self sunsetOffsetByDegrees:kZenithSevenPointZeroEightThree];
}

- (NSDate *) tzaisGeonim8Point5Degrees{
    return  [self sunsetOffsetByDegrees:kZenithEightPointFive];
}

- (NSDate *) tzais60{
    return [[self seaLevelSunset] dateByAddingTimeInterval:60 * kSecondsInAMinute];
}

- (NSDate *) tzaisAteretTorah{
    return [[self seaLevelSunset] dateByAddingTimeInterval:ateretTorahSunsetOffset * kSecondsInAMinute];
}

- (NSDate *) sofZmanShmaAteretTorah{
    return [[self alos72Zmanis] dateByAddingTimeInterval:[self shaahZmanisAteretTorah]*3];
}

- (NSDate *) sofZmanTfilaAteretTorah{
    return [[self alos72Zmanis] dateByAddingTimeInterval:[self shaahZmanisAteretTorah]*4];
}

- (NSDate *) minchaGedolaAteretTorah{
    return [[self alos72Zmanis] dateByAddingTimeInterval:[self shaahZmanisAteretTorah]*6.5];
}

- (NSDate *) minchaKetanaAteretTorah{
    return [[self alos72Zmanis] dateByAddingTimeInterval:[self shaahZmanisAteretTorah]*9.5];
}

- (NSDate *) plagHaminchaAteretTorah{
    return [[self alos72Zmanis] dateByAddingTimeInterval:[self shaahZmanisAteretTorah]*10.75];
}

- (NSDate *) misheyakirAteretTorahWithMinutes:(double)minutes{
    return [[self alos72Zmanis] dateByAddingTimeInterval:minutes*kSecondsInAMinute];
}

- (NSDate *) tzais72Zmanis{
    long shaahZmanis = [self shaahZmanisGra];
    
    if (shaahZmanis == LONG_MIN) {
        return nil;
    }
    
    return [[self seaLevelSunset] dateByAddingTimeInterval:shaahZmanis*1.2];
}

- (NSDate *) tzais90Zmanis{
    long shaahZmanis = [self shaahZmanisGra];
    
    if (shaahZmanis == LONG_MIN) {
        return nil;
    }
    
    return [[self seaLevelSunset] dateByAddingTimeInterval:shaahZmanis*1.5];
}

- (NSDate *) tzais96Zmanis{
    long shaahZmanis = [self shaahZmanisGra];
    
    if (shaahZmanis == LONG_MIN) {
        return nil;
    }
    
    return [[self seaLevelSunset] dateByAddingTimeInterval:shaahZmanis*1.6];
}

- (NSDate *) tzais90{
    return [[self seaLevelSunset] dateByAddingTimeInterval:90*kSecondsInAMinute];
}

- (NSDate *) tzais120{
    return [[self seaLevelSunset] dateByAddingTimeInterval:120*kSecondsInAMinute];
}

- (NSDate *) tzais120Zmanis{
    long shaahZmanis = [self shaahZmanisGra];
    if (shaahZmanis == LONG_MIN) {
        return nil;
    }
    return [[self seaLevelSunset] dateByAddingTimeInterval:shaahZmanis*2.0];
}

- (NSDate *) tzais16Point1Degrees{
    return [self sunsetOffsetByDegrees:kZenithSixteenPointOne];
}

- (NSDate *) tzais26Degrees{
    return [self sunsetOffsetByDegrees:kZenithTwentySix];
}

- (NSDate *) tzais18Degrees{
    return [self sunsetOffsetByDegrees:kZenithAstronomical];
}

- (NSDate *) tzais19Point8Degrees{
    return [self sunsetOffsetByDegrees:kZenithNineteenPointEight];
}

- (NSDate *) tzais96{
    return [[self seaLevelSunset] dateByAddingTimeInterval:96*kSecondsInAMinute];
}

- (NSDate *) fixedLocalChatzos{
    return [[self dateFromTime:(12.0-[self.geoLocation.timeZone secondsFromGMT])] dateByAddingTimeInterval:[self.geoLocation localMeanTimeOffset]];
}

- (NSDate *) sofZmanShmaFixedLocal{
    return [[self fixedLocalChatzos] dateByAddingTimeInterval:-180*kSecondsInAMinute];
}

- (NSDate *) sofZmanTfilaFixedLocal{
    return [[self fixedLocalChatzos] dateByAddingTimeInterval:-120*kSecondsInAMinute];
}

- (NSDate *) sofZmanKidushLevanaBetweenMoldosUsingAlos:(NSDate *)alos andTzais:(NSDate *)tzais{

}

- (NSDate *) sofZmanKidushLevanaBetweenMoldos{

}

- (NSDate *) sofZmanKidushLevana15DaysUsingAlos:(NSDate *)alos andTzais:(NSDate *)tzais{

}

- (NSDate *) sofZmanKidushLevana15Days{

}

- (NSDate *) tchilasZmanKidushLevana3DaysUsingAlos:(NSDate *)alos andTzais:(NSDate *)tzais{

}

- (NSDate *) tchilasZmanKidushLevana3Days{

}

- (NSDate *) tchilasZmanKidushLevana7DaysUsingAlos:(NSDate *)alos andTzais:(NSDate *)tzais{

}

- (NSDate *) tchilasZmanKidushLevana7Days{

}

- (NSDate *) sofZmanAchilasChametzGra{

}

- (NSDate *) sofZmanAchilasChametzMGA72Minutes{

}

- (NSDate *) sofZmanAchilasChametzMGA16Point1Degrees{

}

- (NSDate *) sofZmanBiurChametzGra{

}

- (NSDate *) sofZmanBiurChametzMGA72Minutes{

}

- (NSDate *) sofZmanBiurChametzMGA16Point1Degrees{

}

- (NSDate *)solarMidnight{

}


@end
