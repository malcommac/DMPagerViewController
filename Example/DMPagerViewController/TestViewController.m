//
//  TestViewController.m
//  Example
//
//  Created by daniele on 11/01/15.
//  Copyright (c) 2015 danielemargutti. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor {
	self = [super init];
	if (self) {
		self.view = [[UIView alloc] initWithFrame:CGRectZero];
		self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		self.view.backgroundColor = aBkgColor;
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.text = aText;
		label.font = [UIFont boldSystemFontOfSize:40];
		label.numberOfLines = 1;
		label.textAlignment = NSTextAlignmentCenter;
		label.backgroundColor = [UIColor clearColor];
		label.textColor = [UIColor whiteColor];
		label.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
								  UIViewAutoresizingFlexibleTopMargin    |
								  UIViewAutoresizingFlexibleBottomMargin);
		[self.view addSubview:label];
		
		CGSize bestSize = [label.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
															 options:NSStringDrawingTruncatesLastVisibleLine
															 context:NULL].size;
		label.frame = CGRectMake(0,
								 ((CGRectGetHeight(self.view.frame)-bestSize.height)/2.0f),
								 CGRectGetWidth(self.view.frame),
								 bestSize.height);

	}
	return self;
}

- (DMPagerNavigationBarItem *)pagerItem {
	return self.pagerObj;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
