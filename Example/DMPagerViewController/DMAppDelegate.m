//
//  DMAppDelegate.m
//  DMPagerViewController
//
//  Created by CocoaPods on 01/12/2015.
//  Copyright (c) 2014 Daniele Margutti. All rights reserved.
//

#import "DMAppDelegate.h"

@implementation DMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	NSDictionary *textAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:12.0f],
									  NSForegroundColorAttributeName : [UIColor blackColor]};
	
	UIColor *bkVC1 = [UIColor colorWithRed:0.000 green:0.475 blue:0.647 alpha:1.000];
	UIColor *bkVC2 = [UIColor colorWithRed:0.000 green:0.729 blue:0.984 alpha:1.000];
	UIColor *bkVC3 = [UIColor colorWithRed:0.753 green:0.929 blue:0.996 alpha:1.000];
	
	TestViewController *vc1 = [[TestViewController alloc] initWithText:@"Page #1" backgroundColor:bkVC1];
	vc1.pagerObj = [DMPagerNavigationBarItem newItemWithText: [[NSAttributedString alloc] initWithString:@"HOME" attributes:textAttributes]
													 andIcon: [UIImage imageNamed:@"rchat"]];
	vc1.pagerObj.renderingMode = DMPagerNavigationBarItemModeTextAndImage;
	
	
	TestViewController *vc2 = [[TestViewController alloc] initWithText:@"Page #2" backgroundColor:bkVC2];
	vc2.pagerObj = [DMPagerNavigationBarItem newItemWithText: [[NSAttributedString alloc] initWithString:@"DISCOVER" attributes:textAttributes]
													 andIcon: [UIImage imageNamed:@"gear"]];
	vc2.pagerItem.renderingMode = DMPagerNavigationBarItemModeOnlyImage;
	
	TestViewController *vc3 = [[TestViewController alloc] initWithText:@"Page #3" backgroundColor:bkVC3];
	vc3.pagerObj = [DMPagerNavigationBarItem newItemWithText: [[NSAttributedString alloc] initWithString:@"CHAT" attributes:textAttributes]
													 andIcon: [UIImage imageNamed:@"chat_full"]];
	vc3.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;
	
	// Create pager with items
	self.pagerController = [[DMPagerViewController alloc] initWithViewControllers: @[vc1,vc2,vc3]];
	//self.pagerController.useNavigationBar = NO;
	
	// Setup pager's navigation bar colors
	UIColor *activeColor = [UIColor colorWithRed:0.000 green:0.235 blue:0.322 alpha:1.000];
	UIColor *inactiveColor = [UIColor colorWithRed:.84 green:.84 blue:.84 alpha:1.0];
	self.pagerController.navigationBar.inactiveItemColor = inactiveColor;
	self.pagerController.navigationBar.activeItemColor = activeColor;
	
	self.window.rootViewController = self.pagerController;
	[self.window makeKeyAndVisible];
	
    return YES;
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
