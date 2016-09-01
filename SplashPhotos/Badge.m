//
//  Badge.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/30.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "Badge.h"

@implementation Badge

+(Badge*) fromDictionary: (NSDictionary*) dic
{
    Badge *badge = [[Badge alloc]init];
    
    badge.title =  [dic objectOrNilForKey:@"title"];
    badge.primary =  [dic objectOrNilForKey:@"primary"];
    badge.slug =  [dic objectOrNilForKey:@"slug"];
    badge.link =  [dic objectOrNilForKey:@"link"];
    
    return badge;
}

@end
