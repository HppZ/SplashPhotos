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
    
    urls.full = [dic objectOrNilForKey: @"full"];
    urls.raw = [dic objectOrNilForKey: @"raw"];
    urls.small = [dic objectOrNilForKey: @"small"];
    urls.regular = [dic objectOrNilForKey: @"regular"];
    urls.thumb = [dic objectOrNilForKey: @"thumb"];
    
    return urls;
}
@end
