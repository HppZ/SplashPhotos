//
//  PhotoController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "PhotoController.h"
#import "UnsplashAPIService.h"
#import "DownloadManager.h"
#import "GetPhotosParam.h"

@interface PhotoController()
{
    UnsplashAPIService * _apiService;
}
@end

@implementation PhotoController

-(id)init
{
    self  = [super init];
    if(self)
    {
        _apiService = [UnsplashAPIService sharedInstance];
    }
    return self;
}

#pragma mark public
-(void)loadPhotos: (NSInteger) page complete: (DataRequestResultCompletionBlock) complete
{
    GetPhotosParam * param = [[GetPhotosParam alloc] initWithPage:page perPage:15 sortType: PhotoSortTypeLatest];
    
    [_apiService GetPhotos:param
           completionBlock:^(NSArray * _Nullable data, id  _Nullable response, NSError * _Nullable error)
     {
         complete(data, error);
     }];
}

-(void)requestDownload: (Photo*) photo
{
    [DownloadManager.sharedInstance requestDownload:photo];
}

-(void)restartDownload: (DownloadPhoto*)downloadphoto
{
    [DownloadManager.sharedInstance restartDownload:downloadphoto];
}

-(NSArray*)getDownloadPhotos
{
    return DownloadManager.sharedInstance.downloadedPhotos;
}

@end
