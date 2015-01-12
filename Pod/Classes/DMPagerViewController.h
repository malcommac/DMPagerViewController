//
//  DMPagerViewController.h
//  Pager controller like the one in Twitter or Tinder
//
//  Created by Daniele Margutti (me@danielemargutti.com) on 11/01/15.
//  Copyright (c) 2015 http://www.danielemargutti.com All rights reserved.
//	Distribuited under MIT License http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>
#import "DMPagerNavigationBar.h"

typedef NS_ENUM(NSInteger, DMPagerViewControllerAnimation) {
	DMPagerViewControllerAnimationStandard,			// Standard UIScrollView animation
	DMPagerViewControllerAnimationEaseInOut,		// Ease In+Out animation on scroll
	DMPagerViewControllerAnimationBounceEnd,		// Animation with final bounce
	DMPagerViewControllerAnimationBounceStartEnd	// Animation with initial+final bounce
};

#pragma mark - DMPagerViewControllerProtocol (Child View Controllers Protocol) -

@protocol DMPagerViewControllerProtocol <NSObject>

// Return the item you want to show into DMPagerViewController's navigation bar
- (DMPagerNavigationBarItem *) pagerItem;

@end

#pragma mark - DMPagerViewControllerDelegate (Delegate Protocol) -

@protocol DMPagerViewControllerDelegate <NSObject>

@optional
// Called when a page change did occours
- (void) pager:(DMPagerViewController *) aController didChangePageFrom:(NSInteger) aOldPage to:(NSInteger) aNewPage;
// Called countinously during a scroll operation
- (void) pager:(DMPagerViewController *) aController didScrollTo:(CGPoint) aOffset;

@end

#pragma mark - DMPagerViewController Class -

@interface DMPagerViewController : UIViewController

@property (nonatomic,retain)	NSArray								*controllers;				// Child controllers
@property (nonatomic,weak)		id <DMPagerViewControllerDelegate>	 delegate;					// Events delegate

@property (nonatomic,readonly)	UIScrollView						*scrollView;				// Main content scroll view (you should not use it generally)
@property (nonatomic,assign)	BOOL								 isScrollParallaxed;		// YES to add parallax effect while dragging pages

@property (nonatomic,readonly)	NSInteger							 currentPage;				// Current page (still valid during dragging operation)
@property (nonatomic,readonly)	NSInteger							 nextPage;					// Next proposed page during drag operation

@property (nonatomic,assign)	DMPagerViewControllerAnimation		 animation;					// Animation used for -setPageIndex:animated: (only animated)

@property (nonatomic,assign)	BOOL								 useNavigationBar;			// YES to add a top navigation bar
																								// (controller must implement DMPagerViewControllerProtocol protocol)
@property (nonatomic,assign)	BOOL								 isNavigationBarTouchable;	// YES to make top navigation touchable
@property (nonatomic,assign)	CGFloat								 navigationBarHeight;		// Height of the navigation bar
@property (nonatomic,readonly)	DMPagerNavigationBar				*navigationBar;				// Reference for navigation bar customizations
@property (nonatomic,readonly)	BOOL								 isFullScreen;				// Is view controller presented as full screen view

// Initialize controller with a set of child controllers
- (instancetype) initWithViewControllers:(NSArray *) aControllers;

// Move to a specified page
- (void) setPageIndex:(NSInteger) aPageIndex animated:(BOOL) aAnimated;

// Return controller instance for a specified page
- (UIViewController *) controllerAtPage:(NSInteger) aPageIndex;

@end
