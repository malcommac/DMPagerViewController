//
//  TestViewController.h
//  Example
//
//  Created by daniele on 11/01/15.
//  Copyright (c) 2015 danielemargutti. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DMPagerViewController.h"

@class DMPagerNavigationBarItem;

@interface TestViewController : UIViewController <DMPagerViewControllerProtocol>

@property (nonatomic,strong) DMPagerNavigationBarItem	*pagerObj;

- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor;


@end
