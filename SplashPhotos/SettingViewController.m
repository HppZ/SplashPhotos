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
    BOOL flag;
}

@property (weak, nonatomic) IBOutlet UIImageView *logoElement;
@end

@implementation SettingViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    flag = true;
    [self rotateLogo];
}

-(void)viewDidDisappear:(BOOL)animated
{
    flag = false;
    [self rotateLogo];
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

#pragma mark 旋转logo
-(void)rotateLogo
{
    if(flag)
    {
        [UIView animateWithDuration: 0.2 delay:0 options:UIViewAnimationOptionCurveLinear
                         animations:^
        {
            [self.logoElement setTransform:CGAffineTransformRotate(self.logoElement.transform, M_PI_2)];
        }
                         completion:^(BOOL finished){
            if (finished)
            {
                [self rotateLogo];
            }
        }];
    }
}

@end

