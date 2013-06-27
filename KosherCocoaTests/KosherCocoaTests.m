//
//  KosherCocoaTests.m
//  KosherCocoaTests
//
//  Created by Moshe Berman on 5/9/13.
//
//

#import "KosherCocoaTests.h"

#import "WeeklyParsha.h"

@implementation KosherCocoaTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    
    WeeklyParsha *parasha = [WeeklyParsha new];
    
    NSDate *date = [NSDate date];
    
    [parasha thisWeeksParshaForDate:date inDiaspora:YES];
}

@end
