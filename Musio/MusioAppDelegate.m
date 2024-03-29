//
//  MusioAppDelegate.m
//  Musio
//
//  Created by Oli Young on 7/03/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioAppDelegate.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "MusioAPIClient.h"
#import "TestFlight.h"

@implementation MusioAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TestFlight takeOff:@"124ef203-7599-4df4-9804-2126453f6a73"];

    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval: UIApplicationBackgroundFetchIntervalMinimum];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    NSLog(@"%@", kMusioBaseURLString);
    Reachability* reach = [Reachability reachabilityWithHostname:kMusioBaseURLString];
    reach.unreachableBlock = ^(Reachability*reach) {
        NSLog(@"UNREACHABLE!");
    };
    [reach startNotifier];

    // Override point for customization after application launch.
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    NSURL *userDefaultsURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@/api/v1/devices/iphone.plist", kMusioBaseURLString] ];
    [[NSUserDefaults standardUserDefaults]
     registerDefaultsWithURL:userDefaultsURL
     success:^(NSDictionary *defaults) {}
     failure:^(NSError *error) {}
     ];

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    MusioAPIClient *client = [MusioAPIClient sharedClient];
    NSString *deviceTokenString = [NSString stringWithFormat:@"%@", deviceToken];
    [client postAPNToken:deviceTokenString
                      to:[Lockbox stringForKey:@"user_uuid"]
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     NSLog(@"Success -- %@", responseObject);
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                     NSLog(@"Failure -- %@", error);
                 }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
