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

@interface MainTabBarController ()
{
    PhotoService* _photoService ;
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
    _photoService = [[PhotoService alloc] init];
    
    float fontsize = 15.0f;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:fontsize],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:fontsize],NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    for(UITabBarItem *tabitem in  self.tabBar.items)
    {
         tabitem.titlePositionAdjustment =  UIOffsetMake(0, -15);
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"navigate"
                                               object:nil];
}

#pragma mark navigate
-(void)navigateToCategoryWithName:(NSString*)name
{
    [_photoService setCurrentCategoryWithName:name];
    
    UINavigationController * nc = [self.viewControllers  objectAtIndex:0];
    [nc popToRootViewControllerAnimated:false];
    UIViewController* second =  [self.storyboard instantiateViewControllerWithIdentifier:@"firstTabBarNavigationController"];
    [nc pushViewController:second animated:true];
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
