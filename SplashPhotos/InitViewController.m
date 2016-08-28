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
    self.panMinimumOpenThreshold = 30;
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTabBarController"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"];
    UIImage * bg = [UIImage imageNamed:@"bg"];
    self.backgroundImage = bg;
}

@end
