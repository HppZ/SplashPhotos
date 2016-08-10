//
//  DownloadPhoto.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "DownloadPhoto.h"
#import "Urls.h"

@implementation DownloadPhoto

#pragma mark init
-(id)init
{
    return [self initWithPhoto:nil];
}

-(id)initWithPhoto: (Photo*) photo
{
    self = [super init];
    if(self)
    {
        _photo = photo;
        _thumb = [[[photo urls] small] copy];
        _proress = 0;
        _isCompleted = false;
        _filepath = @"";
    }
    
    return self;
}
@end
