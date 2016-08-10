//
//  SettingManager.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/5.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "SettingManager.h"
#import "UrlHelper.h"
#import "SystemServiceHelper.h"

@implementation SettingManager

-(void)gotoUnsplash
{
    [SystemServiceHelper openWithUrl:[UrlHelper Unsplash]];
}

@end
