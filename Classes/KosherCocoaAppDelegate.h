//
//  ZmanimAppDelegate.h
//  Zmanim
//
//  Created by Moshe Berman on 3/10/11.
//  Copyright 2011 MosheBerman.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KosherCocoaViewController;

@interface KosherCocoaAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    KosherCocoaViewController *viewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet KosherCocoaViewController *viewController;

@end

