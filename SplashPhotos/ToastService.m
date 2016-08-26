//
//  ToastService.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/22.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "ToastService.h"
#import "CRToast.h"

@implementation ToastService

+(void)showToastWithStatus:(NSString*)text
{
    [CRToastManager dismissNotification: true];
    
    NSDictionary *options = @{
                              kCRToastTextKey : text,
                              kCRToastTextColorKey : [UIColor blackColor],
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : [UIColor whiteColor],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              };
    
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{}];
}

+(void)showToastWithStatus:(NSString*)text dissmissAfter:(NSTimeInterval)time
{
    
}

@end
