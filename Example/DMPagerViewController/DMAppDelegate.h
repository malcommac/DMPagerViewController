//
//  DMAppDelegate.h
//  DMPagerViewController
//
//  Created by CocoaPods on 01/12/2015.
//  Copyright (c) 2014 Daniele Margutti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DMPagerViewController/DMPagerViewController.h>

#import "TestViewController.h"

@interface DMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DMPagerViewController	*pagerController;

@end
