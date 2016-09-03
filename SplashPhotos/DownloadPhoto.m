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
        _downloadState = DownloadNotStart;
        _proress = 0;
        _thumb = [[[photo urls] small] copy];
        _filepath = @"";
        _errormsg = @"";
        _photo = photo;
    }
    
    return self;
}

-(void)downloadSuccess: (NSString*)filepath
{
    self.downloadState = DownloadSucceed;
    self.filepath = filepath;
    self.proress = 1;
}

-(void)downloadFailed: (NSString*)errormsg
{
    self.downloadState = DownloadFailed;
    self.errormsg = errormsg;
}

-(void)downloadingPhoto
{
    self.downloadState = Downloading;
    self.proress = 0;
    self.filepath = @"";
    self.errormsg = @"";
}

-(BOOL)downloadSucceed
{
    return self.downloadState == DownloadSucceed;
}

#pragma mark getter

-(NSString*)downloadUrl
{
    return self.photo.urls.raw;
}

@end
