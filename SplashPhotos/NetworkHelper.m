//
//  NetworkHelper.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "NetworkHelper.h"
#import "AFNetworking.h"

@interface NetworkHelper()
{

}
@end

@implementation NetworkHelper

static bool _isWIFI;

#pragma mark init
+ (void)initialize
{
    if (self == [NetworkHelper class])
    {
        [self networkStatusChangeAFN];
    }
}

#pragma mark state
+(bool)isWIFI
{
    return _isWIFI;
}

+(void)networkStatusChangeAFN
{
    //1.获得一个网络状态监听管理者
    AFNetworkReachabilityManager *manager =  [AFNetworkReachabilityManager sharedManager];
    
    //2.监听状态的改变(当网络状态改变的时候就会调用该block)
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        /*
         AFNetworkReachabilityStatusUnknown          = -1,  未知
         AFNetworkReachabilityStatusNotReachable     = 0,   没有网络
         AFNetworkReachabilityStatusReachableViaWWAN = 1,    3G|4G
         AFNetworkReachabilityStatusReachableViaWiFi = 2,   WIFI
         */
        
        _isWIFI = false;
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                _isWIFI = true;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
                
            default:
                break;
        }
        
        [self postNotification];
    }];
    
    //3.手动开启 开始监听
    [manager startMonitoring];
}

#pragma mark 通知
+(void)postNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"networkStatusChanged" object:self];
}

@end
