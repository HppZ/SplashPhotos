//
//  GetPhotosParam.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "GetPhotosParam.h"

@implementation GetPhotosParam

-(id)init
{
    return  nil;
}

-(id)initWithPage: (NSInteger) page perPage: (NSInteger) perPage sortType:(PhotoSortType) orderBy
{
    self = [super init];
    if(self)
    {
        _page = page;
        _perPage = perPage;
        _orderBy = orderBy;
    }
    return self;
}

@end
