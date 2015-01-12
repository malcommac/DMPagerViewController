//
//  DMPagerNavigationBar.h
//  Pager controller like the one in Twitter or Tinder
//
//  Created by Daniele Margutti (me@danielemargutti.com) on 11/01/15.
//  Copyright (c) 2015 http://www.danielemargutti.com All rights reserved.
//	Distribuited under MIT License http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

@class DMPagerViewController,DMPagerNavigationBarItem;

static CGFloat	kNavigationBarOffset = 5.0f;

typedef void(^DMPagerNavigationBarClickHandler)(NSInteger idx,DMPagerNavigationBarItem *item);

typedef NS_ENUM(NSInteger, DMPagerNavigationBarItemMode) {
	DMPagerNavigationBarItemModeTextAndImage,		// Button contains both text and image
	DMPagerNavigationBarItemModeOnlyText,			// Only Text
	DMPagerNavigationBarItemModeOnlyImage			// Only Image
};

typedef NS_ENUM(NSInteger, DMPagerNavigationBarItemColorize) {
	DMPagerNavigationBarItemColorizeWithFade,		// Colorize from inactive<->active item colors with fade based on scroll offset
	DMPagerNavigationBarItemColorizeSolid,			// Solid colorization for inactive/active items
	DMPagerNavigationBarItemIgnore					// No changes are applied to color, use your own
};

typedef NS_ENUM(NSInteger, DMPagerNavigationBarStyle) {
	DMPagerNavigationBarStyleOnBounds		= 40,
	DMPagerNavigationBarStyleClose			= 30,
	DMPagerNavigationBarStyleNormal			= 20,
	DMPagerNavigationBarStyleFar			= 10,
	DMPagerNavigationBarStyleDefault		= 0,
	DMPagerNavigationBarStyleCloseToEachOne = -40
};

#pragma mark - DMPagerNavigationBarItem Navigation Bar Item -

@interface DMPagerNavigationBarItem : UIView

@property (nonatomic,retain)	NSAttributedString				*title;					// Title of the item (as attributed string)
@property (nonatomic,retain)	UIImage							*icon;					// Image of the item (will be used as template)
@property (nonatomic,assign)	DMPagerNavigationBarItemMode	 renderingMode;			// Rendering mode of the item

// Create a new item
+ (DMPagerNavigationBarItem *) newItemWithText:(NSAttributedString *) aTitle andIcon:(UIImage *) aIcon;

@end


#pragma mark - DMPagerNavigationBar Navigation Bar -

@interface DMPagerNavigationBar : UIView

// Create a new navigation bar (you should not use it)
- (instancetype) initWithController:(DMPagerViewController *) aController;

@property (nonatomic,retain)	NSArray								*items;					// You should not touch it
@property (nonatomic,copy)		DMPagerNavigationBarClickHandler	 action;

@property (nonatomic,assign)	DMPagerNavigationBarStyle			 style;					// Style of the navigation (items positioning)
@property (nonatomic,strong)	UIColor								*activeItemColor;		// Inactive item tint color
@property (nonatomic,strong)	UIColor								*inactiveItemColor;		// Active item tint color
@property (nonatomic,assign)	DMPagerNavigationBarItemColorize	 colorizeMode;			// Colorization mode of the items

@end
