//
//  GetUserProfileParam.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "GetUserProfileParam.h"

@implementation GetUserProfileParam

-(id)init
{
    return  nil;
}

-(id)initWithName: (NSString*) username   w: (NSInteger) w h: (NSInteger) h
{
    self = [super init];
    if(self)
    {
        _username = [username copy];
        _w = w;
        _h = h;
    }
    return self;
}

@end
