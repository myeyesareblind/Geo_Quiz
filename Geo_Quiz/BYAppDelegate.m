//
//  BYAppDelegate.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYAppDelegate.h"

@interface BYAppDelegate()

- (void) loadStandartUserDefaults;

@end

@implementation BYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self loadStandartUserDefaults];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NBY_ApplicationDidEnterBackGround
                                                        object:NULL];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NBY_ApplicationDidEnterForeGround
                                                        object:NULL];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) loadStandartUserDefaults {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    BOOL standartsLoaded = [ud boolForKey:UDBY_StandartUserDefaultsLoaded];
    if (! standartsLoaded) {
        [ud setBool:YES
             forKey:UDBY_SoundEnabled];
        [ud setBool:YES
             forKey:UDBY_StandartUserDefaultsLoaded];
    }
}
@end