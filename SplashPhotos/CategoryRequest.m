//
//  CategoryRequest.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CategoryRequest.h"

@implementation CategoryRequest

-(id)init
{
    return [self initWithId:0];
}

-(id)initWithId: (int)id
{
    self = [super init];
    if(self)
    {
        _id = id;
        _page = 1;
        _isloading = false;
        _result = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
