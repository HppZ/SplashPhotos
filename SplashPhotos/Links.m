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
    Links * links = [[Links alloc] init];
    
    links.download = [dic objectOrNilForKey: @"download"];
    links.html = [dic objectOrNilForKey: @"html"];
    links.self_ = [dic objectOrNilForKey: @"self"];
    links.photos = [dic objectOrNilForKey: @"photos"];
    links.likes = [dic objectOrNilForKey: @"likes"];
    links.related = [dic objectOrNilForKey: @"related"];
    
    return links;
}
@end
