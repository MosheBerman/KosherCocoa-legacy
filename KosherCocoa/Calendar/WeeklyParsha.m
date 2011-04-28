//
//  WeeklyParsha.m
//  ParshaPort
//				
//  Created by Moshe Berman on 1/17/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import "WeeklyParsha.h"
#import "KosherCocoaConstants.h"

#define kOutOfRangeString @"<Error:> Parsha out of range."

@implementation WeeklyParsha

@synthesize parshios;

//A delimiter for parsha combinations
#define kDelimiter @"-"


- (id) init{
	if (self == [super init]) {
		
		//
		//	Populate the parshios array
		//
		
		self.parshios = [NSMutableArray arrayWithObjects:@"Bereishit", @"Noach", @"Lech-Lecha", @"Vayera", @"Chayei Sara", 
								@"Toldot", @"Vayetzei", @"Vayishlach", @"Vayeshev", @"Miketz", @"Vayigash", @"Vayechi", 
								@"Shemot", @"Vaera", @"Bo", @"Beshalach", @"Yitro", @"Mishpatim", @"Terumah", @"Tetzaveh",
								@"Ki Tisa", @"Vayakhel", @"Pekudei", @"Vayikra", @"Tzav", @"Shmini", @"Tazria", @"Metzora", 
								@"Achrei Mot", @"Kedoshim", @"Emor", @"Behar", @"Bechukotai", @"Bamidbar", 
								@"Nasso", @"Beha'alotcha", @"Sh'lach", @"Korach", @"Chukat", @"Balak", @"Pinchas",
								@"Matot", @"Masei", @"Devarim", @"Vaetchanan", @"Eikev", @"Re'eh", @"Shoftim", @"Ki Teitzei",
								@"Ki Tavo", @"Nitzavim", @"Vayeilech", @"Ha'Azinu", @"Vezot Habracha", nil];
								

	}
	
	return self;
}

#pragma mark -

- (NSInteger)  currentHebrewYear{
	return [self hebrewYearForDate:[NSDate date]];
	
}

- (NSInteger) hebrewYearForDate:(NSDate *)date{
    
	NSCalendar *hebrewCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar] autorelease];
	
	NSDateComponents *todayInHebrewComponents = [hebrewCalendar components:NSYearCalendarUnit fromDate:date]; 
	return [todayInHebrewComponents year];
}

#pragma mark - Year Length

- (NSInteger) lengthOfYearForYear:(NSInteger)year{
    
    //
    //
    //
    
	NSCalendar *hebrewCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar];
	
    //
	//	Then get the first day of the current hebrew year
	//
	
	NSDateComponents *roshHashanaComponents = [[[NSDateComponents alloc] init ]autorelease];
	
	[roshHashanaComponents setDay:1];
	[roshHashanaComponents setMonth:1];
	[roshHashanaComponents setYear:year];
	[roshHashanaComponents setHour:12];
	[roshHashanaComponents setMinute:0];
	[roshHashanaComponents setSecond:0];
	
	NSDate *roshHashanaDate = [hebrewCalendar dateFromComponents:roshHashanaComponents];
	
	//
	//	Then convert that to gregorian
	//
	
	NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	NSDateComponents *gregorianDayComponentsForRoshHashana = [gregorianCalendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit fromDate:roshHashanaDate];
	
	//Determine the day of the week of the first day of the current hebrew year
    
	NSDate *oneTishreiAsGregorian = [gregorianCalendar dateFromComponents:gregorianDayComponentsForRoshHashana];
	
	//
	//	Then get the first day of the current hebrew year
	//
	
	NSDateComponents *roshHashanaOfNextYearComponents = [[NSDateComponents alloc] init ];
	
    NSInteger tempYear = year+1;
    
	[roshHashanaOfNextYearComponents setDay:1];
	[roshHashanaOfNextYearComponents setMonth:1];
	[roshHashanaOfNextYearComponents setYear:tempYear];
	[roshHashanaOfNextYearComponents setHour:12];
	[roshHashanaOfNextYearComponents setMinute:0];
	[roshHashanaOfNextYearComponents setSecond:0];
	
	NSDate *roshHashanaOfNextYearAsDate = [hebrewCalendar dateFromComponents:roshHashanaOfNextYearComponents];
	
    [roshHashanaOfNextYearComponents release];
    
    [hebrewCalendar release];
    
	//
	//	Then convert that to gregorian
	//
	
	NSDateComponents *gregorianDayComponentsForRoshHashanaOfNextYear = [gregorianCalendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit fromDate:roshHashanaOfNextYearAsDate];
	
	//Determine the first day of the week of the next hebrew year
	NSDate *oneTishreiOfNextYearAsGregorian = [gregorianCalendar dateFromComponents:gregorianDayComponentsForRoshHashanaOfNextYear];
	
	//	Length of this year in days	
	NSTimeInterval totalDaysInTheYear = [oneTishreiOfNextYearAsGregorian timeIntervalSinceReferenceDate] - [oneTishreiAsGregorian timeIntervalSinceReferenceDate];
	
	//
	//	We round here because of slight offsets in the Gregorian calendar.
	//
	
	totalDaysInTheYear = totalDaysInTheYear/86400;
    
    //NSLog(@"Total Days in Year: %f", totalDaysInTheYear);
    
    totalDaysInTheYear = round(totalDaysInTheYear);
    
   //NSLog(@"Total Days in Year: %f", totalDaysInTheYear);
    
    if(totalDaysInTheYear == 353 || totalDaysInTheYear == 383){
		totalDaysInTheYear = 0;
	}else if(totalDaysInTheYear == 354 || totalDaysInTheYear == 384){
		totalDaysInTheYear = 1;
	}else if(totalDaysInTheYear == 355 || totalDaysInTheYear == 385){
		totalDaysInTheYear = 2;
	}
    
    return totalDaysInTheYear;
    
}

#pragma mark - ytype

- (NSArray *) yearTypeForYear:(NSInteger)year{

    //NSLog(@"year: %d", year);
    
	//totalDaysInTheYear is either "maleh", "chaser", or "regular"
	NSInteger isLeapYear, firstDayOfWeekOfTheHebrewYear;
    NSTimeInterval totalDaysInTheYear;

	//Determine if this year is a leap year (could be Boolean)
	isLeapYear = [self isHebrewLeapYear:year]?1:0;
	
    //
    //
    //
    
	NSCalendar *hebrewCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar];
	
    //
	//	Then get the first day of the current hebrew year
	//
	
	NSDateComponents *roshHashanaComponents = [[[NSDateComponents alloc] init ]autorelease];
	
	[roshHashanaComponents setDay:1];
	[roshHashanaComponents setMonth:1];
	[roshHashanaComponents setYear:year];
	[roshHashanaComponents setHour:12];
	[roshHashanaComponents setMinute:0];
	[roshHashanaComponents setSecond:0];
	
	NSDate *roshHashanaDate = [hebrewCalendar dateFromComponents:roshHashanaComponents];
	
	//
	//	Then convert that to gregorian
	//
	
	NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	NSDateComponents *gregorianDayComponentsForRoshHashana = [gregorianCalendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit fromDate:roshHashanaDate];
	
	//Determine the day of the week of the first day of the current hebrew year

	NSDate *oneTishreiAsGregorian = [gregorianCalendar dateFromComponents:gregorianDayComponentsForRoshHashana];
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:oneTishreiAsGregorian];
	NSInteger weekday = [[NSNumber numberWithUnsignedInteger:[comps weekday]] integerValue];
	
	//
	// Get the day of the week as an integer
	//
	
	firstDayOfWeekOfTheHebrewYear = weekday;
	
	//
	//	TODO: Convert these to constants later
	//
	//	The numbers 2,3,5,7 represent Monday, 
	//	Tuesday, Thursday and Saturday
	//
	
	//Rosh Hashana can be Monday, Tuesday, Thursday, Shabbos 
	if (firstDayOfWeekOfTheHebrewYear == 2) {
		firstDayOfWeekOfTheHebrewYear = 0;
	}else if (firstDayOfWeekOfTheHebrewYear == 3) {
		firstDayOfWeekOfTheHebrewYear = 1;
	}else if (firstDayOfWeekOfTheHebrewYear == 5) {
		firstDayOfWeekOfTheHebrewYear = 2;
	}else if(firstDayOfWeekOfTheHebrewYear == 7){
		firstDayOfWeekOfTheHebrewYear = 3;
	}
	
    /*
	//
	//	Then get the first day of the current hebrew year
	//
	
	NSDateComponents *roshHashanaOfNextYearComponents = [[NSDateComponents alloc] init ];
	
    NSInteger tempYear = year+1;
    
	[roshHashanaOfNextYearComponents setDay:1];
	[roshHashanaOfNextYearComponents setMonth:1];
	[roshHashanaOfNextYearComponents setYear:tempYear];
	[roshHashanaOfNextYearComponents setHour:12];
	[roshHashanaOfNextYearComponents setMinute:0];
	[roshHashanaOfNextYearComponents setSecond:0];
	
	NSDate *roshHashanaOfNextYearAsDate = [hebrewCalendar dateFromComponents:roshHashanaOfNextYearComponents];
	
    [roshHashanaOfNextYearComponents release];
    
    [hebrewCalendar release];
    
	//
	//	Then convert that to gregorian
	//
	
	NSDateComponents *gregorianDayComponentsForRoshHashanaOfNextYear = [gregorianCalendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit fromDate:roshHashanaOfNextYearAsDate];
	
	
	//Determine the first day of the week of the next hebrew year
	NSDate *oneTishreiOfNextYearAsGregorian = [gregorianCalendar dateFromComponents:gregorianDayComponentsForRoshHashanaOfNextYear];
	
	//	Length of this year in days	
	totalDaysInTheYear = [oneTishreiOfNextYearAsGregorian timeIntervalSinceReferenceDate] - [oneTishreiAsGregorian timeIntervalSinceReferenceDate];
	
	//
	//	We round here because of slight offsets in the Gregorian calendar.
	//
	
	totalDaysInTheYear = round(totalDaysInTheYear/86400);
	
    //NSLog(@"Total days in the year: %f", totalDaysInTheYear);
    
	if(totalDaysInTheYear == 353 || totalDaysInTheYear == 383){
		totalDaysInTheYear = 0;
	}
    if(totalDaysInTheYear == 354 || totalDaysInTheYear == 384){
		totalDaysInTheYear = 1;
	}
    if(totalDaysInTheYear == 355 || totalDaysInTheYear == 385){
		totalDaysInTheYear = 2;
	}
	*/
    
    totalDaysInTheYear = [self lengthOfYearForYear:year];
    
	//
	//	Convert to the values to NSNumbers and return them inside of an array
	//
	
	NSArray *temp = [NSArray arrayWithObjects: [NSNumber numberWithInteger: isLeapYear], [NSNumber numberWithInteger:firstDayOfWeekOfTheHebrewYear], [NSNumber numberWithInteger:totalDaysInTheYear], nil];
	
	return temp;
}

#pragma mark -
#pragma mark Array manipulation methods

#pragma mark psh

- (NSMutableArray *) addParsha:(NSString *)parsha toMutableArray:(NSMutableArray *)mutableArray{
	
	[mutableArray insertObject:parsha atIndex:0];
	
	return mutableArray;
}

#pragma mark -
#pragma mark Padd


- (NSMutableArray *) insertParsha:(NSString *)parsha intoMutableArray:(NSMutableArray *)mutableArray atIndex:(NSUInteger)index{
	[mutableArray insertObject:parsha atIndex:index];
	return mutableArray;
}

#pragma mark -
#pragma mark Pcom

- (NSMutableArray *) combineParshiosFromIndex:(NSUInteger)index fromMutableArray:(NSMutableArray *)mutableArray{
	NSString *delimiter = kDelimiter;
	
	[mutableArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%@%@%@",[mutableArray objectAtIndex:index] ,delimiter,[mutableArray objectAtIndex:index+1]]];
	[mutableArray removeObjectAtIndex:index+1];
	
	//
	//	kToDoTempString is a flag that the item must be
	//	removed when "uncombining" parshiyos
	//

	//[mutableArray insertObject:kToDoTempString atIndex:index+1];
	
	return mutableArray;
}

#pragma mark -
#pragma mark parshaParse

- (NSMutableArray *) rearrangeParshiosForDiasporaInArray:(NSMutableArray *)mutableArray BasedOnTypeOfYear:(NSArray *)typeOfYear{
	
	//
	//	A copy of the parshios array
	//
	
	NSMutableArray *tempArray = [[mutableArray mutableCopy] autorelease];
	
    //Is this a leap year?
	NSInteger a = [[typeOfYear objectAtIndex:0] integerValue];
	
    //The first day of the week of the hebrew year
	NSInteger b = [[typeOfYear objectAtIndex:1] integerValue];
	
    //The length of the hebrew year
	NSInteger c = [[typeOfYear objectAtIndex:2] integerValue];
	
	//
	//	How many times we combined the parshios already
	//
	
	NSInteger combinations = 0;
    
    //

    if (a==0&&b==0&&c==0){
        
        //
        //  Combine the necessary parshios
        //
        
        [self combineParshiosFromIndex:21 fromMutableArray:tempArray];
        combinations++;
        
        //
        //  Insert Holidays
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:25-1];
        
        //
        //  Add parshios to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Sukkos" toMutableArray:tempArray];
        [self addParsha:@"Ha'Azinu" toMutableArray:tempArray];  
        [self addParsha:@"Vayelech" toMutableArray:tempArray];        
    }
    
    if(a==0&&b==0&&c==2||a==0&&b==1&&c==1){
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:21 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:26-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:28-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:31-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:38-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:50-combinations fromMutableArray:tempArray];
        
        //
        //  Insert Chol Hamoed
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:25-1];
        tempArray = [self insertParsha:@"Shavuot 2" intoMutableArray:tempArray atIndex:32-1];
        
        //
        //  Add parshios to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        [self addParsha:@"Vayelech" toMutableArray:tempArray];        

    }
    if(a==0&&b==2&&c==2){
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:26 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:28-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:31-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];

        //
        //  Insert Pesach
        //
        
         tempArray = [self insertParsha:@"Pesach 7" intoMutableArray:tempArray atIndex:26-1];

        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Yom Kippur" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray];        

    }
    
    if(a==0&&b==2&&c==1){
        
        combinations = 0;
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:21 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:26-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:28-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:31-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        
        //
        //  Insert Pesach
        //
        
         tempArray = [self insertParsha:@"Pesach 1" intoMutableArray:tempArray atIndex:25-1];
         tempArray = [self insertParsha:@"Pesach 8" intoMutableArray:tempArray atIndex:26-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Yom Kippur" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
    }
    
    if(a==0&&b==3&&c==0){
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:21 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:26-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:28-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:31-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:38-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        
        //
        //  Insert Pesach
        //
        
         tempArray = [self insertParsha:@"Pesach 7" intoMutableArray:tempArray atIndex:25-1];

        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Shmini Atzeres" toMutableArray:tempArray];
        [self addParsha:@"Sukkos 1" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray]; 
        [self addParsha:@"Rosh Hashana 1" toMutableArray:tempArray];         

    }
    
    if(a==0&&b==3&&c==2){

        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:21 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:26-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:28-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:31-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:38-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:50-combinations fromMutableArray:tempArray];
  
        //
        //  Insert Pesach
        //
        
         tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:25-1];

        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Shmini Atzeres" toMutableArray:tempArray];
        [self addParsha:@"Sukkos 1" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray]; 
        [self addParsha:@"Rosh Hashana 1" toMutableArray:tempArray];  
    }
    if(a==1&&b==0&&c==0){
       
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:38 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:50-combinations fromMutableArray:tempArray];

        //
        //  Insert Pesach and Shavuos
        //
        
         tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:29-1];
         tempArray = [self insertParsha:@"Shavuos 2" intoMutableArray:tempArray atIndex:36-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        [self addParsha:@"Vayelech" toMutableArray:tempArray];  
        
    }
    
    if(a==1&&b==0&&c==2||a==1&&b==1&&c==1){
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:41 fromMutableArray:tempArray];

        //
        //  Insert Chol Hamoed
        //
        
         tempArray = [self insertParsha:@"Pesach 1" intoMutableArray:tempArray atIndex:29-1];
         tempArray = [self insertParsha:@"Pesach 8" intoMutableArray:tempArray atIndex:30-1];

        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        [self addParsha:@"Vayelech" toMutableArray:tempArray];  
        
    }
    
    if(a==1&&b==2&&c==0){
        
        //
        //  Insert Chol Hamoed
        //
        
         tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:30-1];
        
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Yom Kippur" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        
    }
    
    if(a==1&&b==2&&c==2){
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:50 fromMutableArray:tempArray];
        
        //
        //  Insert Chol Hamoed
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:30-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Yom Kippur" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        
    }
    
    if(a==1&&b==3&&c==0){
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:41 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:50-combinations fromMutableArray:tempArray];

        //
        //  Insert Chol Hamoed
        //
        
         tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:29-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Shmini Atzeres" toMutableArray:tempArray];
        [self addParsha:@"Sukkos 1" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray]; 
        [self addParsha:@"Rosh Hashana 1" toMutableArray:tempArray]; 
    }
    if(a==1&&b==3&&c==2){
       
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:38 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:50-combinations fromMutableArray:tempArray];

        //
        //  Insert Pesach and Shavuos
        //
        
         tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:29-1];
         tempArray = [self insertParsha:@"Shavuos 2" intoMutableArray:tempArray atIndex:36-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Shmini Atzeres" toMutableArray:tempArray];
        [self addParsha:@"Sukkos 1" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray]; 
        [self addParsha:@"Rosh Hashana 1" toMutableArray:tempArray]; 
    }
    
    return tempArray;
    
}

- (NSMutableArray *) rearrangeParshiosForIsraelInArray:(NSMutableArray *)mutableArray BasedOnTypeOfYear:(NSArray *)typeOfYear{
	
	//
	//	A copy of the parshios array
	//
	
	NSMutableArray *tempArray = [[mutableArray mutableCopy] autorelease];
	
    //Is this a leap year?
	NSInteger a = [[typeOfYear objectAtIndex:0] integerValue];
	
    //The first day of the week of the hebrew year
	NSInteger b = [[typeOfYear objectAtIndex:1] integerValue];
	
    //The length of the hebrew year
	NSInteger c = [[typeOfYear objectAtIndex:2] integerValue];
	
	//
	//	How many times we combined the parshios already
	//
	
	NSInteger combinations = 0;
    
    //
    
    if (a==0&&b==0&&c==0){
        
        //
        //  Combine the necessary parshios
        //
        
        [self combineParshiosFromIndex:21 fromMutableArray:tempArray];
        combinations++;
        
        //
        //  Insert Holidays
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:25-1];
        
        //
        //  Add parshios to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Sukkos" toMutableArray:tempArray];
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        [self addParsha:@"Vayelech" toMutableArray:tempArray];        
    }
    
    if(a==0&&b==0&&c==2||a==0&&b==1&&c==1){
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:21 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:26-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:28-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:31-combinations fromMutableArray:tempArray];
        combinations++;
        //[self combineParshiosFromIndex:38-combinations fromMutableArray:tempArray];
        //combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:50-combinations fromMutableArray:tempArray];
        
        //
        //  Insert Chol Hamoed
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:25-1];
        
        //
        //  Add parshios to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        [self addParsha:@"Vayelech" toMutableArray:tempArray];        
        
    }
    if(a==0&&b==2&&c==2){
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:26 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:28-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:31-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        
        //
        //  Insert Pesach
        //
        
        tempArray = [self insertParsha:@"Pesach 7" intoMutableArray:tempArray atIndex:26-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Yom Kippur" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray];        
        
    }
    
    if(a==0&&b==2&&c==1){
        
        combinations = 0;
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:21 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:26-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:28-combinations fromMutableArray:tempArray];
        combinations++;
        // [self combineParshiosFromIndex:31-combinations fromMutableArray:tempArray];
        // combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        
        //
        //  Insert Pesach
        //
        
        tempArray = [self insertParsha:@"Pesach 1" intoMutableArray:tempArray atIndex:25-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Yom Kippur" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
    }
    
    if(a==0&&b==3&&c==0){
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:21 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:26-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:28-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:31-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:38-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        
        //
        //  Insert Pesach
        //
        
        tempArray = [self insertParsha:@"Pesach 7" intoMutableArray:tempArray atIndex:25-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Shmini Atzeres" toMutableArray:tempArray];
        [self addParsha:@"Sukkos 1" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray]; 
        [self addParsha:@"Rosh Hashana 1" toMutableArray:tempArray];         
        
    }
    
    if(a==0&&b==3&&c==2){
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:21 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:26-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:28-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:31-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:38-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:50-combinations fromMutableArray:tempArray];

        
        //
        //  Insert Pesach
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:25-1];
        
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Shmini Atzeres" toMutableArray:tempArray];
        [self addParsha:@"Sukkos 1" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray]; 
        [self addParsha:@"Rosh Hashana 1" toMutableArray:tempArray];  
    }
    if(a==1&&b==0&&c==0){
        
        //
        //  Double up the parshios
        //
        
        //[self combineParshiosFromIndex:38 fromMutableArray:tempArray];
        //combinations++;
        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:50-combinations fromMutableArray:tempArray];

        
        //
        //  Insert Pesach and Shavuos
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:29-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        [self addParsha:@"Vayelech" toMutableArray:tempArray];  
        
    }
    
    if(a==1&&b==0&&c==2||a==1&&b==1&&c==1){
        
        //
        //  We don't double any parshiot in Israel this year!
        //
        
        //
        //  Insert Chol Hamoed
        //
        
        tempArray = [self insertParsha:@"Pesach 1" intoMutableArray:tempArray atIndex:29-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        [self addParsha:@"Vayelech" toMutableArray:tempArray];  
        
    }
    
    if(a==1&&b==2&&c==0){
        
        //
        //  Insert Chol Hamoed
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:30-1];
        
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Yom Kippur" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        
    }
    
    if(a==1&&b==2&&c==2){
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:50 fromMutableArray:tempArray];
        
        //
        //  Insert Chol Hamoed
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:30-1];
        
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Chol Hamoed Succos" toMutableArray:tempArray];
        [self addParsha:@"Yom Kippur" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray];  
        
    }
    
    if(a==1&&b==3&&c==0){
        
        //
        //  Double up the parshios
        //
        
        [self combineParshiosFromIndex:41 fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:50-combinations fromMutableArray:tempArray];
        
        //
        //  Insert Chol Hamoed
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:29-1];
        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Shmini Atzeres" toMutableArray:tempArray];
        [self addParsha:@"Sukkos 1" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray]; 
        [self addParsha:@"Rosh Hashana 1" toMutableArray:tempArray]; 
    }
    if(a==1&&b==3&&c==2){
        
        //
        //  A test year would be 1929
        //
        
        //
        //  Double up the parshios
        //

        [self combineParshiosFromIndex:41-combinations fromMutableArray:tempArray];
        combinations++;
        [self combineParshiosFromIndex:50-combinations fromMutableArray:tempArray];
        
        //
        //  Insert Pesach
        //
        
        tempArray = [self insertParsha:@"Chol Hamoed Pesach" intoMutableArray:tempArray atIndex:29-1];

        
        //
        //  Add parshios and holidays to the begining of the year
        //
        
        [self addParsha:@"Shmini Atzeres" toMutableArray:tempArray];
        [self addParsha:@"Sukkos 1" toMutableArray:tempArray];  
        [self addParsha:@"Haazinu" toMutableArray:tempArray]; 
        [self addParsha:@"Rosh Hashana 1" toMutableArray:tempArray]; 
    }
    
    return tempArray;
    
}

#pragma mark -
#pragma mark ranger

- (NSArray *)createArrayWithNumbersInRange:(NSRange)aRange{
	NSMutableArray *tempArray = [[[NSMutableArray alloc] init] autorelease];
	
	for (NSInteger i=aRange.location; i<aRange.length + aRange.location; i++) {
		[tempArray addObject:[NSNumber numberWithInteger:i]];
	}
	
	return [[tempArray copy] autorelease];
}

//
//
//

- (BOOL) isHebrewLeapYear:(NSInteger)year{
	return ((7 * year + 1) % 19) < 7;
}


#pragma mark -
#pragma mark ties it all to her

- (NSString *) thisWeeksParshaForDate:(NSDate *)date inDiaspora:(BOOL)isInDiaspora{
	
	//Create a Hebrew Calendar
	NSCalendar *hebrewCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar] autorelease];
	
	//Create a Gregorian Calendar
	NSCalendar *gregorianCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	
	NSDateComponents *gregorianDateComponents = [gregorianCalendar components:NSWeekdayCalendarUnit fromDate:date];
 	
	int weekday = [gregorianDateComponents weekday];
	
	//Get the date of this shabbos
	NSDate *thisShabbos = [NSDate dateWithTimeInterval:(kSecondsInADay * (7-weekday)) sinceDate:date];
	
	NSDateComponents *shabbosComponents = [hebrewCalendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:thisShabbos];
	
	NSDateComponents *roshHashanaComponents = [[[NSDateComponents alloc] init ]autorelease];
	
	[roshHashanaComponents setDay:1];
	[roshHashanaComponents setMonth:1];
	[roshHashanaComponents setYear:[shabbosComponents year]];
	[roshHashanaComponents setHour:12];
	[roshHashanaComponents setMinute:0];
	[roshHashanaComponents setSecond:0];
	
	NSDate *roshHashanaDate = [hebrewCalendar dateFromComponents:roshHashanaComponents];
	
	NSDate *firstShabbosOfTheYear = [NSDate dateWithTimeInterval:(kSecondsInADay * (7 - [roshHashanaComponents weekday])) sinceDate:roshHashanaDate];
	
	//	Determine the number of days since the first shabbos of the year until this shabbos
	
	NSInteger weekNumber = [thisShabbos timeIntervalSinceDate:firstShabbosOfTheYear]/60/60/24;

    //
    //  If there is negative time since rosh hashana, we're in next year,
    //  so adjust the current year then re-evaluate the current week.
    //
    
    if (weekNumber < 0 ) {
        
        [shabbosComponents setYear:[shabbosComponents year]-1];
        
       	[roshHashanaComponents setDay:1];
        [roshHashanaComponents setMonth:1];
        [roshHashanaComponents setYear:[shabbosComponents year]];
        [roshHashanaComponents setHour:12];
        [roshHashanaComponents setMinute:0];
        [roshHashanaComponents setSecond:0];
        
        NSDate *roshHashanaDate = [hebrewCalendar dateFromComponents:roshHashanaComponents];
        
        NSDate *firstShabbosOfTheYear = [NSDate dateWithTimeInterval:(kSecondsInADay * (7 - [roshHashanaComponents weekday])) sinceDate:roshHashanaDate];
        
        //
        //	Determine the number of days since the first shabbos of the year until this shabbos
        //
        
        weekNumber = [thisShabbos timeIntervalSinceDate:firstShabbosOfTheYear]/60/60/24;
 
    } 

    weekNumber = (weekNumber/7)+1;    
    
	//
	//	Rearrange the parshios
	//
	
	NSMutableArray *temp;
	
	if(isInDiaspora == YES){
		temp = [self rearrangeParshiosForDiasporaInArray:self.parshios BasedOnTypeOfYear:[self yearTypeForYear:[shabbosComponents year]]];
	}else if (isInDiaspora == NO) {
		temp = [self rearrangeParshiosForIsraelInArray:self.parshios BasedOnTypeOfYear:[self yearTypeForYear:[shabbosComponents year]]];
	}
	
	//
	//	Then look up this weeks parsha
	//
	
	NSString *parsha;
	
	if(weekNumber < [temp count]){
		parsha = [temp objectAtIndex:weekNumber];
	}else {
		parsha = kOutOfRangeString;
	}
	
	return parsha;
}

- (NSString *) nextWeeksParshaForDate:(NSDate *)date inDiaspora:(BOOL)isInDiaspora{
    
    //Create a Gregorian Calendar
	NSCalendar *gregorianCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    NSDateComponents *gregorianDateComponents = [gregorianCalendar components:NSWeekdayCalendarUnit fromDate:date];
 	
	int weekday = [gregorianDateComponents weekday];
    
    //Get the date of next shabbos
	NSDate *nextShabbos = [NSDate dateWithTimeInterval:(kSecondsInADay * (7-weekday))+(kSecondsInADay*7) sinceDate:date];
     
    return [self thisWeeksParshaForDate:nextShabbos inDiaspora:isInDiaspora];
}

#pragma mark - Year type string

- (NSString *)yearTypeStringForDate:(NSDate *)date{
 	
	//Create a Hebrew Calendar
	NSCalendar *hebrewCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar] autorelease];
    
    //Create a Gregorian Calendar
	NSCalendar *gregorianCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	
	NSDateComponents *gregorianDateComponents = [gregorianCalendar components:NSWeekdayCalendarUnit fromDate:date];
 	
	int weekday = [gregorianDateComponents weekday];
    
    //Get the date of next shabbos
	NSDate *nextShabbos = [NSDate dateWithTimeInterval:(kSecondsInADay * (7-weekday)) sinceDate:date];
	
	NSDateComponents *shabbosComponents = [hebrewCalendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:nextShabbos];
    
    NSArray *yearType = [self yearTypeForYear:[shabbosComponents year]];

    return [yearType description];
}

#pragma mark -


- (void) dealloc {
	[super dealloc];
	[parshios release];
}


@end
