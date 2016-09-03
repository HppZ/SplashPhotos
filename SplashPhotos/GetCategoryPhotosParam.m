//
//  GetCategoryPhotosParam.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "GetCategoryPhotosParam.h"

@implementation GetCategoryPhotosParam

-(id)init
{
    return  nil;
}

-(id)initWithId: (NSString*) id   page: (NSInteger) page perPage: (NSInteger) perPage
{
    self = [super init];
    if(self)
    {
        _id = [id copy];
        _page = page;
        _perPage = perPage;
    }
    return self;
}

@end
