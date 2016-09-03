//
//  SystemService.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemService.h"

@implementation SystemService

+(void)openWithUrl:(NSString*) url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}

@end
