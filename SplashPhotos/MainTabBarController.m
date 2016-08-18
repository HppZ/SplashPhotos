//
//  MainTabController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

#pragma mark view setup
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup
{
    float fontsize = 15.0f;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:fontsize],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:fontsize],NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    for(UITabBarItem *tabitem in  self.tabBar.items)
    {
         tabitem.titlePositionAdjustment =  UIOffsetMake(0, -15);
    }
}

#pragma mark side menu
-(void)awakeFromNib
{
     
}

@end
