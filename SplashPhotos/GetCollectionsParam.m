//
//  GetCollectionsParam.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "GetCollectionsParam.h"

@implementation GetCollectionsParam

-(id)init
{
    return  nil;
}

-(id)initWithPage:(NSInteger) page perPage: (NSInteger) perPage
{
    self = [super init];
    if(self)
    {
        _page = page;
        _perPage = perPage;
    }
    return self;
}

@end
