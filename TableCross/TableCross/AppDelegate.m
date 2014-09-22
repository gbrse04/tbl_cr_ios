//
//  AppDelegate.m
//  TableCross
//
//  Created by TableCross on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "AppDelegate.h"
#import "SplashViewController.h"
#import "MTReachabilityManager.h"
#import "Reachability.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    //Init network monitor
    
    [MTReachabilityManager sharedManager];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SplashViewController *loginVC = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    //Set background for navigation bar
    UIImage *navBarBackgroundImage = [UIImage imageNamed:IS_IOS7?@"bg_nav_64.png": @"bg_nav.png"];
    [[UINavigationBar appearance] setBackgroundImage:navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    //Set title navigation bar color
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], UITextAttributeTextColor,
                                                           [UIColor darkGrayColor],UITextAttributeTextShadowColor,
                                                           [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                           UITextAttributeTextShadowOffset,
                                                           [UIFont fontWithName:@"Kozuka Gothic Pr6N" size:18.0], UITextAttributeFont, nil]];
    
       [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [navController setNavigationBarHidden:YES];
    self.window.rootViewController = navController;
    
    //    [self customTitleColor];
    
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
    //
    return YES;
}

#pragma mark Network Notification Handling

- (void)reachabilityDidChange:(NSNotification *)notification {
    Reachability *reachability = (Reachability *)[notification object];
    if(reachability )
    {
        if ([reachability isReachable]) {
            
            gIsHasNetwork=true;
            NSLog(@"Reachable");
            
        } else {
            gIsHasNetwork=false;
            NSLog(@"Unreachable");
            
            // [Util showMessage:kMsgNetworkError withTitle:kAppNameManager];
        }
    }
    
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
    
    [self initCoreLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark  - Handle facebook open 

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBSession.activeSession handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [FBSession.activeSession handleOpenURL:url];
}


#pragma mark INIT LOCATION MANAGER


-(void)initCoreLocation
{
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Location service is now disable." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        gIsEnableLocation = NO;
    }
    else
    {
        gIsEnableLocation = YES;
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLHeadingFilterNone;
        //        self.locationManager.purpose = @"To calculate the distance to dealer";
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    gCurrentLatitude = location.coordinate.latitude;
    gCurrentLongitude = location.coordinate.longitude;
    
    [self.locationManager stopUpdatingLocation];
}



@end
