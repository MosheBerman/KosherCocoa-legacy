//
//  ComplexZmanimCalendar.h
//  KosherCocoa
//
//  Created by Moshe Berman on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZmanimCalendar.h"

@interface ComplexZmanimCalendar : ZmanimCalendar

- (long) shaahZmanis19Point8Degrees;

- (long) shaahZmanis18Degrees;

- (long) shaahZmanis16Degrees;

- (long) shaahZmanis16Point1Degrees;

- (long) shaahZmanis60Minutes;

- (long) shaahZmanis72Minutes;

- (long) shaahZmanis72MinutesZmanis;

- (long) shaahZmanis90Minutes;

- (long) shaahZmanis90MinutesZmanis;

- (long) shaahZmanis96Minutes;

- (long) shaahZmanis96MinutesZmanis;

- (long) shaahZmanisAteretTorah;

- (long) shaahZmanis120Minutes;

- (long) shaahZmanis120MinutesZmanis;

- (NSDate *) plagHamincha120Minutes;

- (NSDate *) plagHamincha120MinutesZmanis;

- (NSDate *) alos60;

- (NSDate *) alos72Zmanis;

- (NSDate *) alos90;

- (NSDate *) alos90Zmanis;

- (NSDate *) alos96;

- (NSDate *) alos96Zmanis;

- (NSDate *) alos120;

- (NSDate *) alos120Zmanis;

- (NSDate *) alos26Degrees;

- (NSDate *) alos18Degrees;

- (NSDate *) alos19Point8Degrees;

- (NSDate *) alos16Point1Degrees;

- (NSDate *) misheyakir11Point5Degrees;

- (NSDate *) misheyakir11Degrees;

- (NSDate *) misheyakir10Point2Degrees;

- (NSDate *) sofZmanShmaMGA19Point8Degrees;

- (NSDate *) sofZmanShmaMGA16Point1Degrees;

- (NSDate *) sofZmanShmaMGA72Minutes;

- (NSDate *) sofZmanShmaMGA72MinutesZmanis;

- (NSDate *) sofZmanShmaMGA90Minutes;

- (NSDate *) sofZmanShmaMGA90MinutesZmanis;

- (NSDate *) sofZmanShmaMGA96Minutes;

- (NSDate *) sofZmanShmaMGA96MinutesZmanis;

- (NSDate *) sofZmanShma3HoursBeforeChatzos;

- (NSDate *) sofZmanShmaMGA120Minutes;

- (NSDate *) sofZmanShmaAlos16Point1ToSunset;

- (NSDate *) sofZmanShmaAlos16Point1ToTzaisGeonim7Point083Degrees;

- (NSDate *) sofZmanShmaKolEliyahu;

- (NSDate *) sofZmanTfilaMGA19Point8Degrees;

- (NSDate *) sofZmanTfilaMGA16Point1Degrees;

- (NSDate *) sofZmanTfilaMGA72Minutes;

- (NSDate *) sofZmanTfilaMGA72MinutesZmanis;

- (NSDate *) sofZmanTfilaMGA90Minutes;

- (NSDate *) sofZmanTfilaMGA90MinutesZmanis;

- (NSDate *) sofZmanTfilaMGA96Minutes;

- (NSDate *) sofZmanTfilaMGA96MinutesZmanis;

- (NSDate *) sofZmanTfilaMGA120Minutes;

- (NSDate *) sofZmanTfila2HoursBeforeChatzos;

- (NSDate *) minchaGedola30Minutes; //after chatzos

- (NSDate *) minchaGedola72Minutes;

- (NSDate *) minchaGedola16Point1Degrees;

- (NSDate *) minchaGedolaGreaterThan30;

- (NSDate *) minchaKetana16Point1Degrees;

- (NSDate *) minchaKetana72Minutes;

- (NSDate *) plagHamincha60Minutes;

- (NSDate *) plagHamincha72Minutes;

- (NSDate *) plagHamincha90Minutes;

- (NSDate *) plagHamincha96Minutes;

//
//  TODO: Reorder these to follow the logical pairing
//

- (NSDate *) plagHamincha96MinutesZmanis;

- (NSDate *) plagHamincha90MinutesZmanis;

- (NSDate *) plagHamincha72MinutesZmanis;

- (NSDate *) plagHamincha16Point1Degrees;

- (NSDate *) plagHamincha19Point8Degrees;

- (NSDate *) plagHamincha26Degrees;

- (NSDate *) plagHamincha18Degrees;

- (NSDate *) plagAlosToSunset;

- (NSDate *) plagAlos16Point1ToTzaisGeonim7Point083Degrees;

- (NSDate *) bainHashmashosRT13Degrees;

- (NSDate *) bainHashmashosRT58Point5Minutes;

- (NSDate *) bainHashmashosRT13Point5MinutesBefore7Point083Degrees;

- (NSDate *) bainHashmashosRT2Stars;

- (NSDate *) tzaisGeonim5Point95Degrees;

- (NSDate *) tzaisGeonim3Point65Degrees;

- (NSDate *) tzaisGeonim4Point61Degrees;

- (NSDate *) tzaisGeonim4Point37Degrees;

- (NSDate *) tzaisGeonim5Point88Degrees;

- (NSDate *) tzaisGeonim4Point8Degrees;

- (NSDate *) tzaisGeonim7Point083Degrees;

- (NSDate *) tzaisGeonim8Point5Degrees;

- (NSDate *) tzais60;

- (NSDate *) tzaisAteretTorah;

- (NSDate *) sofZmanShmaAteretTorah;

- (NSDate *) sofZmanTfilaAteretTorah;

- (NSDate *) minchaGedolaAteretTorah;

- (NSDate *) minchaKetanaAteretTorah;

- (NSDate *) plagHaminchaAteretTorah;

- (NSDate *) mesheyakirAteretTorah;

- (NSDate *) tzais72Zmanis;

- (NSDate *) tzais90Zmanis;

- (NSDate *) tzais96Zmanis;

- (NSDate *) tzais90;

- (NSDate *) tzais120;

- (NSDate *) tzais120Zmanis;

- (NSDate *) tzais16Point1Degrees;

- (NSDate *) tzais26Degrees;

- (NSDate *) tzais18Degrees;

- (NSDate *) tzais19Point8Degrees;

- (NSDate *) tzais96;

- (NSDate *) fixedLocalChatzos;

- (NSDate *) sofZmanShmaFixedLocal;

- (NSDate *) sofZmanTfilaFixedLocal;

- (NSDate *) sofZmanKidushLevanaBetweenMoldosUsingAlos:(NSDate *)alos andTzais:(NSDate *)tzais;

- (NSDate *) sofZmanKidushLevanaBetweenMoldos;

- (NSDate *) sofZmanKidushLevana15DaysUsingAlos:(NSDate *)alos andTzais:(NSDate *)tzais;

- (NSDate *) sofZmanKidushLevana15Days;

- (NSDate *) tchilasZmanKidushLevana3DaysUsingAlos:(NSDate *)alos andTzais:(NSDate *)tzais;

- (NSDate *) tchilasZmanKidushLevana3Days;

- (NSDate *) tchilasZmanKidushLevana7DaysUsingAlos:(NSDate *)alos andTzais:(NSDate *)tzais;

- (NSDate *) tchilasZmanKidushLevana7Days;

- (NSDate *) sofZmanAchilasChametzGra;

- (NSDate *) sofZmanAchilasChametzMGA72Minutes;

- (NSDate *) sofZmanAchilasChametzMGA16Point1Degrees;

- (NSDate *) sofZmanBiurChametzGra;

- (NSDate *) sofZmanBiurChametzMGA72Minutes;

- (NSDate *) sofZmanBiurChametzMGA16Point1Degrees;

- (NSDate *)solarMidnight;

@end






