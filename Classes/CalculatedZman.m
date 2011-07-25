//
//  CalculatedZman.m
//  KosherCocoa
//
//  Created by Moshe Berman on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatedZman.h"

@implementation CalculatedZman

@synthesize name, time;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.name = @"Unvailable";
        self.time = @"Unvailable";        
    }
    
    return self;
}

- (void)dealloc{
    
    [name release];
    [time release];
    [super dealloc];
}
@end
