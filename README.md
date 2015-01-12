# DMPagerViewController

[![CI Status](http://img.shields.io/travis/Daniele Margutti/DMPagerViewController.svg?style=flat)](https://travis-ci.org/Daniele Margutti/DMPagerViewController)
[![Version](https://img.shields.io/cocoapods/v/DMPagerViewController.svg?style=flat)](http://cocoadocs.org/docsets/DMPagerViewController)
[![License](https://img.shields.io/cocoapods/l/DMPagerViewController.svg?style=flat)](http://cocoadocs.org/docsets/DMPagerViewController)
[![Platform](https://img.shields.io/cocoapods/p/DMPagerViewController.svg?style=flat)](http://cocoadocs.org/docsets/DMPagerViewController)

DMPagerViewController is a UIViewController subclass which mimics the navigation system used in Twitter and Tinder clients for iOS. It also add some special effects like icon tint color fade on scroll and page parallax effect during scroll.
It also offer several configuration options you can easily see in .h file.
Because an image worth more than thousand of words this is a short gif which show you the class.

<div style="width:100%;">
<img src="Example/Demo.gif" align="center" height="50%" width="50%" style="margin-left:20px;">
</div>

<p><p>

## A short introduction

To run the example project, clone the repo, and run `pod install` from your project.

Then you can create a new DMPagerViewController which contains your child view controllers like this:

```
UIViewController * vc1 = ...;
UIViewController * vc2 = ...;
UIViewController * vc3 = ...;
self.pagerController = [[DMPagerViewController alloc] initWithViewControllers: @[vc1,vc2,vc3]];

```

Your child view controllers must be conform to `DMPagerViewControllerProtocol` protocol in order to return the appropriate item to show into the navigation bar (used only when `.useNavigationBar` is set to YES).

So each view controller must implement:

```
- (DMPagerNavigationBarItem *)pagerItem {
	 DMPagerNavigationBarItem *item;
	 UIImage *itemIcon = ...;
	 NSAttributedString *itemTitle = ...;
	 item = [DMPagerNavigationBarItem newItemWithText:itemTitle andIcon: itemIcon];
	item.renderingMode = DMPagerNavigationBarItemModeOnlyText;
	return item;
}
```

Using `.renderingMode` you can decide what show for a specified item (the icon, icon and text or only the text).

You can choose between three different transitions to use when moving programmatically between pages using `-setPageIndex:animated:`:

```
typedef NS_ENUM(NSInteger, DMPagerViewControllerAnimation) {
	// Standard UIScrollView animation
	DMPagerViewControllerAnimationStandard,
	// Ease In+Out animation on scroll
	DMPagerViewControllerAnimationEaseInOut,
	// Animation with final bounce
	DMPagerViewControllerAnimationBounceEnd,
	// Animation with initial+final bounce
	DMPagerViewControllerAnimationBounceStartEnd
};
```

Navigation Bar can also be customized (it's an UIView): you can decide what kind of transition (in term of colors) you want to use for navigation bar items: take a look at `.colorizeMode` (`DMPagerNavigationBarItemColorize`).
Also you can decide the layout of the navigation bar itself via `.style` property (`DMPagerNavigationBarStyle`)

You can push it from a navigation stack or put it into the root window.
You can also access to navigationBar configuration via .navigationBar property.


## Requirements
It works fine with iOS 8. Should work in iOS7 but I've not tested it.

## Installation

DMPagerViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "DMPagerViewController"

## Author

Daniele Margutti
Mail: [me@danielemargutti.com](mailto://me@danielemargutti.com)
Web: [danielemargutti.com](http://www.danielemargutti.com)

## License

DMPagerViewController is available under the MIT license. See the LICENSE file for more info.
