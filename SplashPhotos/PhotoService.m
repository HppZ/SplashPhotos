//
//  PhotoService.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/7.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "PhotoService.h"
#import "PhotoManager.h"
#import "DownloadManager.h"
#import "NetworkHelper.h"

@interface PhotoService()
{
    bool isWIFI;
    
    PhotoManager * photoManager;
    DownloadManager * downloadManager;
}
@end

@implementation PhotoService

#pragma mark init
-(id)init
{
    self = [super init];
    if(self)
    {
        isWIFI = [NetworkHelper isWIFI];
        photoManager = [PhotoManager sharedPhotoManager];
        downloadManager = [DownloadManager sharedDownloadManager];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:)
                                                     name:@"networkStatusChanged"
                                                   object:nil];
        
    }
    
    return self;
}


#pragma mark 网络状态

- (void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"networkStatusChanged"])
    {
        [self networkStatusChangedHandler];
    }
}

-(void)networkStatusChangedHandler
{
    isWIFI = [NetworkHelper isWIFI];
}

#pragma mark 数据源
-(NSMutableArray*)getDataSource
{
    return [photoManager getDataSource];
}

-(NSMutableArray*)getDownloadDataSource
{
    return [downloadManager getDownloadDataSource];
}


#pragma mark 请求
-(void)loadMoreDataWithCallback:(void(^) (NSString* errormsg)) success
{
    [photoManager  loadMoreDataWithCallback:success];
}

-(void)requestDownload: (Photo*) photo
{
    [downloadManager requestDownload:photo];
}

-(int)getCurrentPageNum
{
    return [photoManager getCurrentPageNum];
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
