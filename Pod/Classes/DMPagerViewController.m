//
//  DMPagerViewController.m
//  Pager controller like the one in Twitter or Tinder
//
//  Created by Daniele Margutti (me@danielemargutti.com) on 11/01/15.
//  Copyright (c) 2015 http://www.danielemargutti.com All rights reserved.
//	Distribuited under MIT License http://opensource.org/licenses/MIT
//

#import "DMPagerViewController.h"

static CGFloat	kDeviationFactor		= 0.5f;

@interface DMPagerViewController () <UIScrollViewDelegate> {
	// Scroll session variables
	NSInteger		previousPage;
	NSInteger		sessionCurrentPage;
	NSInteger		sessionNextPage;
	CGFloat			lastContentOffset;
	BOOL			ignorePageChangeUntilDecelerated;
}

@end

@implementation DMPagerViewController

- (instancetype) initWithViewControllers:(NSArray *) aControllers {
	self = [super init];
	if (self) {
		_scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
		_scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
		_scrollView.backgroundColor = [UIColor whiteColor];
		_scrollView.delegate = self;
		_scrollView.pagingEnabled = YES;
		_scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.showsVerticalScrollIndicator = NO;
		[self.view addSubview:_scrollView];
		
		_navigationBarHeight = 44.0f;
		_isNavigationBarTouchable = YES;
		_useNavigationBar = YES;
		_isScrollParallaxed = YES;
		self.controllers = aControllers;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
//	self.edgesForExtendedLayout = UIRectEdgeNone;
//	self.extendedLayoutIncludesOpaqueBars = NO;
//	self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - Properties -

- (BOOL) isFullScreen {
	return CGRectEqualToRect(self.view.bounds, [UIScreen mainScreen].bounds);
}

- (void)setNavigationBarHeight:(CGFloat)navigationBarHeight {
	if (_navigationBarHeight == navigationBarHeight) return;
	_navigationBarHeight = navigationBarHeight;
	[self adjustControllerLayout];
}

- (NSInteger)currentPage {
	return lround( _scrollView.contentOffset.x / CGRectGetWidth(_scrollView.frame) );
}

- (NSInteger)nextPage {
	NSInteger cPage = self.currentPage;
	return ( _scrollView.contentOffset.x < (cPage*CGRectGetWidth(_scrollView.frame)) ? cPage-1 : cPage+1);
}

- (void)setUseNavigationBar:(BOOL)useNavigationBar {
	_useNavigationBar = useNavigationBar;
	if (_useNavigationBar) {
		NSMutableArray *allItems = [NSMutableArray arrayWithCapacity:_controllers.count];
		for (UIViewController *cViewController in _controllers) {
			if ([cViewController conformsToProtocol:@protocol(DMPagerViewControllerProtocol)])
				[allItems addObject: [((UIViewController <DMPagerViewControllerProtocol>*)cViewController) pagerItem]];
			else
				[NSException raise:NSCocoaErrorDomain format:@"UIViewController %@ <%p> does not conform to DMPagerViewControllerProtocol protocol",cViewController,cViewController];
		}
		
		__typeof__(self) __weak weakSelf = self;
		_navigationBar = [[DMPagerNavigationBar alloc] initWithController:self];
		_navigationBar.items = allItems;
		_navigationBar.style = DMPagerNavigationBarStyleDefault;
		_navigationBar.activeItemColor = self.view.window.tintColor;
		_navigationBar.inactiveItemColor = [UIColor darkGrayColor];
		_navigationBar.action = ^(NSInteger idx,DMPagerNavigationBarItem *item) {
			if (weakSelf.isNavigationBarTouchable)
				[weakSelf setPageIndex:idx animated:YES];
		};
		[self.view addSubview:_navigationBar];
	} else {
		[_navigationBar removeFromSuperview];
		_navigationBar = nil;
	}
	[self adjustControllerLayout];
	[self adjustPagerNavigationBarOnScroll];
}

- (void) setPageIndex:(NSInteger) aPageIndex animated:(BOOL) aAnimated {
	if (aPageIndex < 0 || aPageIndex >= _controllers.count)
		return;
	
	CGPoint scrollOffset = CGPointMake( aPageIndex*CGRectGetWidth(_scrollView.frame), 0.0f);
	CGRect scrollRect = CGRectMake(scrollOffset.x, scrollOffset.y, _scrollView.frame.size.width, _scrollView.frame.size.height);
	
	if (!aAnimated) {
		[_scrollView setContentOffset:scrollOffset animated:NO];
		return;
	}
	
	BOOL prevParallaxSettings = _isScrollParallaxed;
	_isScrollParallaxed = NO;
	[self adjustScrollViewSubviewsFrames];
	
	switch (_animation) {
		case DMPagerViewControllerAnimationStandard:
		default: {
			[UIView animateWithDuration: 0.35
							 animations:^{
								 [_scrollView setContentOffset:scrollOffset animated:NO];
							 } completion:^(BOOL finished) {
								 _isScrollParallaxed = prevParallaxSettings;
							 }];
			break;}
		case DMPagerViewControllerAnimationEaseInOut: {
			[UIView animateWithDuration: 0.35f
								  delay: 0.0f
								options: UIViewAnimationOptionCurveEaseInOut
							 animations:^{
								 [_scrollView scrollRectToVisible: scrollRect animated:NO];
							 }
							 completion:^(BOOL finished) {
								 _isScrollParallaxed = prevParallaxSettings;
							 }];
			break;}
		case DMPagerViewControllerAnimationBounceStartEnd:{
			CGFloat offset = .15*(scrollOffset.x - _scrollView.contentOffset.x);
			[UIView animateWithDuration: .35
								  delay: 0.0f
								options: UIViewAnimationOptionCurveEaseInOut
							 animations:^{
								 [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x-(offset/2), 0.0f) animated:NO];
							 } completion:^(BOOL finished){
								 [UIView animateWithDuration: .35
													   delay: 0.0f
													 options: UIViewAnimationOptionCurveEaseInOut
												  animations:^{
													  [_scrollView setContentOffset:CGPointMake(scrollOffset.x+offset, 0.0f) animated:NO];
												  } completion:^(BOOL finished){
													  [UIView animateWithDuration:.35 animations:^{
														  [_scrollView setContentOffset:CGPointMake(scrollOffset.x, 0.0f) animated:NO];
													  } completion:^(BOOL finished) {
														  _isScrollParallaxed = prevParallaxSettings;
													  }];
												  }];
							 }];
			break;}
		case DMPagerViewControllerAnimationBounceEnd: {
			CGFloat offset = .15*(scrollOffset.x - _scrollView.contentOffset.x);
			[UIView animateWithDuration: .35
								  delay: 0.0f
								options: UIViewAnimationOptionCurveEaseInOut
							 animations:^{
				[_scrollView setContentOffset:CGPointMake(scrollOffset.x+offset, 0.0f) animated:NO];
			} completion:^(BOOL finished){
				[UIView animateWithDuration:.35 animations:^{
					[_scrollView setContentOffset:CGPointMake(scrollOffset.x, 0.0f) animated:NO];
				} completion:^(BOOL finished) {
					_isScrollParallaxed = prevParallaxSettings;
				}];
			}];
			break;}
	}
}

- (void)setControllers:(NSArray *)aControllers {
	if ([_controllers isEqualToArray:aControllers]) return;
	[_controllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
	[_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	_controllers = aControllers;
	[self adjustScrollViewSubviewsFrames];
	self.useNavigationBar = self.useNavigationBar;
	previousPage = self.currentPage;
}

- (UIViewController *) controllerAtPage:(NSInteger) aPageIndex {
	if (aPageIndex < 0 || aPageIndex >= _controllers.count) return nil;
	return _controllers[aPageIndex];
}

#pragma mark - Layout Routines -

- (void) adjustPagerNavigationBarOnScroll {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
	[_navigationBar performSelector:@selector(pagerScrollerDidScroll:) withObject: _scrollView];
#pragma clang diagnostic pop
}

- (void) adjustScrollViewSubviewsFrames {
	for (NSUInteger idx = 0; idx < _controllers.count; ++idx) {
		UIViewController *cViewController = _controllers[idx];
		[self addChildViewController:cViewController];

		CGRect cViewControllerFrame = CGRectMake( (idx*CGRectGetWidth(_scrollView.frame)), 0.0f,
												 CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
		cViewController.view.frame = cViewControllerFrame;
		[_scrollView addSubview:cViewController.view];
	}
}

- (void) adjustControllerLayout {
	CGRect scrollViewFrame = CGRectZero;
	CGRect navigationBarFrame = CGRectZero;
	CGFloat navBarTotalHeight = _navigationBarHeight + (self.isFullScreen ? CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)+kNavigationBarOffset : 0.0f);
	
	if (!_useNavigationBar) {
		scrollViewFrame = self.view.bounds;
	} else {
		navigationBarFrame = CGRectMake(0.0f, 0.0f,CGRectGetWidth(self.view.frame), navBarTotalHeight);
		scrollViewFrame = CGRectMake(0.0f, CGRectGetMaxY(navigationBarFrame) ,
									 CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-navBarTotalHeight);
	}
	_navigationBar.frame = navigationBarFrame;
	_scrollView.frame = scrollViewFrame;
	_scrollView.contentSize = CGSizeMake( _controllers.count*CGRectGetWidth(self.view.frame), CGRectGetHeight(scrollViewFrame));
}

#pragma mark - ScrollView Events -

- (void)scrollViewWillBeginDragging:(UIScrollView *)aScrollView {
	sessionCurrentPage = lround( aScrollView.contentOffset.x / CGRectGetWidth(aScrollView.frame) );
	previousPage = sessionCurrentPage;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	[self adjustScrollViewSubviewsFrames];
	ignorePageChangeUntilDecelerated = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	ignorePageChangeUntilDecelerated = decelerate;
	
	if (self.delegate)
		[self.delegate pager:self didChangePageFrom:previousPage to:self.currentPage];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
	[self adjustPagerNavigationBarOnScroll]; // Adjust navigation bar scrolling

	if ([_delegate respondsToSelector:@selector(pager:didScrollTo:)])
		[self.delegate pager:self didScrollTo:aScrollView.contentOffset];
	
	if (!_isScrollParallaxed)
		return;
	
	// Parallax effect on subviews
	if (!ignorePageChangeUntilDecelerated)
		sessionNextPage = (lastContentOffset > aScrollView.contentOffset.x ? (sessionCurrentPage-1) : (sessionCurrentPage+1));

	UIViewController *nextVC = (sessionNextPage >= 0 && sessionNextPage < _controllers.count ? _controllers[sessionNextPage] : nil);
	UIViewController *currentVC = (sessionCurrentPage >= 0 && sessionCurrentPage < _controllers.count ? _controllers[sessionCurrentPage] : nil);
	CGFloat deviation = fabsf(aScrollView.contentOffset.x-(sessionCurrentPage*CGRectGetWidth(_scrollView.frame)));
	BOOL isMovingForward = (sessionNextPage > sessionCurrentPage);
	
	CGRect currentVCFrame = CGRectMake((sessionCurrentPage*CGRectGetWidth(self.view.frame)), 0.0f,
									   CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
	if (isMovingForward && currentVC) {
		[_scrollView bringSubviewToFront:nextVC.view];
		currentVCFrame.origin.x += (deviation * kDeviationFactor);
	} else if (!isMovingForward && currentVC) {
		[_scrollView sendSubviewToBack:currentVC.view];
		currentVCFrame.origin.x -= (deviation * kDeviationFactor);
	}
	currentVC.view.frame = currentVCFrame;
	lastContentOffset = aScrollView.contentOffset.x;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
