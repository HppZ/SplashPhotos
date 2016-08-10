//
//  Links.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "Links.h"

@implementation Links

+(Links*) fromDictionary: (NSDictionary*) dic
{
    Links * urls = [[Links alloc] init];
    
    urls.download = [dic objectForKey: @"download"];
    urls.html = [dic objectForKey: @"html"];
    urls.self_ = [dic objectForKey: @"self"];
    
    return urls;
}
@end
