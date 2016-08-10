//
//  SettingViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/5.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingManager.h"

@interface SettingViewController ()
{
    SettingManager* settingManager;
}
@end

@implementation SettingViewController

#pragma mark view setup
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup
{
    settingManager = [[SettingManager alloc] init];
}

#pragma mark 打开官网
- (IBAction)gotoUnsplash:(UIButton *)sender
{
    [settingManager gotoUnsplash];
}
@end
