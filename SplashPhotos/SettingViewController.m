//
//  SettingViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/5.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "SettingViewController.h"
#import "SystemService.h"
#import "UrlHelper.h"

@interface SettingViewController ()
{
    BOOL flag;
}

@property (weak, nonatomic) IBOutlet UIImageView *logoElement;
@end

@implementation SettingViewController

#pragma mark view setup
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark 打开官网
- (IBAction)gotoUnsplash:(UIButton *)sender
{
    [SystemService openWithUrl:[UrlHelper Unsplash]];
}

@end

