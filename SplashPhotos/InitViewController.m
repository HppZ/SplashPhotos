//
//  InitViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/18.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "InitViewController.h"

@implementation InitViewController

#pragma mark init
- (void)awakeFromNib
{
    [self setupSideMenu];
}

#pragma mark side menu
-(void)setupSideMenu
{
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = YES;
    self.contentViewScaleValue = 0.95;
    self.panMinimumOpenThreshold = 30;
    self.contentViewInLandscapeOffsetCenterX = -30.f;
    self.contentViewInPortraitOffsetCenterX  = -30.f;

    
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTabBarController"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"];
    self.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.delegate = self;
}

@end
