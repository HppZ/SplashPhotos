//
//  ToastService.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/22.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "ToastService.h"
#import "JDStatusBarNotification.h"

@implementation ToastService

+(void)showToastWithStatus:(NSString*)text
{
    [JDStatusBarNotification showWithStatus:text dismissAfter:1];
}

+(void)showToastWithStatus:(NSString*)text dissmissAfter:(NSTimeInterval)time
{
    [JDStatusBarNotification showWithStatus:text dismissAfter: time];
}

@end
