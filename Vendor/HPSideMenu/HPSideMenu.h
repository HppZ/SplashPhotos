//
//  HPSideMenu.h
//  HPSideMenu
//
//  Created by HaoPeng on 16/8/26.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef IBInspectable
#define IBInspectable
#endif

@interface HPSideMenu : UIViewController <UIGestureRecognizerDelegate>

@property (strong, readwrite, nonatomic) IBInspectable NSString *contentViewStoryboardID;
@property (strong, readwrite, nonatomic) IBInspectable NSString *leftMenuViewStoryboardID;

@property (strong, readwrite, nonatomic) UIViewController *contentViewController;
@property (strong, readwrite, nonatomic) UIViewController *leftMenuViewController;

@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;
@property (strong, readwrite, nonatomic) UIImage *backgroundImage;
@property (assign, readwrite, nonatomic) BOOL panGestureEnabled;
@property (assign, readwrite, nonatomic) BOOL panFromEdge;
@property (assign, readwrite, nonatomic) NSUInteger panMinimumOpenThreshold;

@property (assign, readwrite, nonatomic) IBInspectable CGFloat contentViewInLandscapeOffsetCenterX;
@property (assign, readwrite, nonatomic) IBInspectable CGFloat menuViewInLandscapeOffsetCenterX;

- (id)initWithContentViewController:(UIViewController *)contentViewController
             leftMenuViewController:(UIViewController *)leftMenuViewController;

- (void)presentLeftMenuViewController;

- (void)hideMenuViewController;
- (void)setContentViewController:(UIViewController *)contentViewController animated:(BOOL)animated;

@end




