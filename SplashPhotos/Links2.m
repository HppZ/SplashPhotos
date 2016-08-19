//
//  Links2.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "Links2.h"

@implementation Links2

+(Links2*) fromDictionary: (NSDictionary*) dic
{
    Links2 * Links  = [[Links2 alloc] init];
    
    Links.self_ = [dic objectForKey: @"self"];
    Links.photos = [dic objectForKey: @"photos"];
    
    return Links;
}

@end
