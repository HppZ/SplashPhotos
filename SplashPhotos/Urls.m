//
//  Urls.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "Urls.h"

@implementation Urls

+(Urls*) fromDictionary: (NSDictionary*) dic
{
    Urls * urls = [[Urls alloc] init];
    
    urls.full = [dic objectForKey: @"full"];
    urls.raw = [dic objectForKey: @"raw"];
    urls.small = [dic objectForKey: @"small"];
    urls.regular = [dic objectForKey: @"regular"];
    urls.thumb = [dic objectForKey: @"thumb"];
    
    return urls;
}
@end
