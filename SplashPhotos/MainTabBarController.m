//
//  MainTabController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "MainTabBarController.h"
#import "PhotoCollectionViewController.h"
#import "PhotoService.h"
#import "CategoryPhotosCollectionViewController.h"

@interface MainTabBarController ()
{
}
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

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"navigate"
                                               object:nil];
}

#pragma mark navigate
-(void)navigateToCategoryWithName:(NSString*)name
{
    UINavigationController * nc = [self.viewControllers  objectAtIndex:0];
    [nc popToRootViewControllerAnimated:false];
    
    // to category
    CategoryPhotosCollectionViewController* category =  [self.storyboard instantiateViewControllerWithIdentifier:@"categoryViewController"];
    category.categoryName = name;
    [nc pushViewController:category animated:true];
    self.selectedIndex = 0;
}

#pragma mark 通知
- (void) receiveNotification:(NSNotification *) notification
{
    NSString* str = [notification name];
    if ([str isEqualToString:@"navigate"])
    {
        NSString* name =  [notification.userInfo objectForKey:@"name"];
        [self navigateToCategoryWithName: name];
    }
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
