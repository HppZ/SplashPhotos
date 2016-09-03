//
//  MainTabController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "MainTabBarController.h"
#import "PhotoCollectionViewController.h"
#import "SplashControllerAccess.h"
#import "CategoryPhotosCollectionViewController.h"
#import "Category.h"

@interface MainTabBarController ()
{
}
@end

@implementation MainTabBarController

#pragma mark view setup
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark side menu
-(void)awakeFromNib
{
    
}

-(void)setup
{
    float fontsize = 15.0f;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:fontsize],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:fontsize],NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    self.tabBar.items[0].titlePositionAdjustment=  UIOffsetMake(0, -15);
    self.tabBar.items[1].titlePositionAdjustment=  UIOffsetMake(-4, -15);
    self.tabBar.items[2].titlePositionAdjustment=  UIOffsetMake(9, -15);
    self.tabBar.items[3].titlePositionAdjustment=  UIOffsetMake(0, -15);
}

#pragma mark navigate
-(void)navigateToCategory:(Category*)category
{
    UINavigationController * nc = [self.viewControllers  objectAtIndex:0];
    [nc popToRootViewControllerAnimated:false];
    
    // to category
    CategoryPhotosCollectionViewController* categoryVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"categoryViewController"];
    categoryVC.category = category;
    [nc pushViewController:categoryVC animated:true];
    self.selectedIndex = 0;
}

-(void)navigateTo:(id)param
{
    if([param isKindOfClass:[Category class]])
    {
        [self navigateToCategory: (Category*)param];
    }
}

#pragma mark dealloc
-(void)dealloc
{
   
}

@end
