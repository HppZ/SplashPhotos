//
//  DownloadManager.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/5.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadManager.h"
#import "UnsplashAPIService.h"
#import "Urls.h"
#import "FileOperationManager.h"

@interface DownloadManager ()
{
    UnsplashAPIService* _apiService;
    NSMutableArray<DownloadPhoto*>* _downloadPhotos;
}

@end

@implementation DownloadManager

#pragma mark 单例
+ (DownloadManager*)sharedInstance
{
    static DownloadManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        _downloadPhotos = [[NSMutableArray<DownloadPhoto*> alloc] init];
        _apiService = [UnsplashAPIService sharedInstance];
    }
    
    return self;
}

#pragma mark getter
-(NSArray*)downloadedPhotos
{
    return _downloadPhotos;
}

#pragma mark public

-(void)requestDownload: (Photo*) photo
{
    DownloadPhoto * downloadphoto = [[DownloadPhoto alloc] initWithPhoto:photo];
    [self addToDownload:downloadphoto];
    [self startDownload:downloadphoto];
}

-(void)restartDownload: (DownloadPhoto*)downloadphoto
{
    if(downloadphoto.downloadState == DownloadFailed)
    {
        [self startDownload:downloadphoto];
    }
}

-(void)cancelDownload:(DownloadPhoto*) photo
{

}

#pragma mark private
-(void) startDownload:(DownloadPhoto*)downloadphoto
{
    [downloadphoto downloadingPhoto];
    
    [_apiService downloadTaskWithURL:downloadphoto.downloadUrl
                                    progress:^(NSProgress * _Nonnull downloadProgress)
     {
                                        [downloadphoto setProress:downloadProgress.fractionCompleted];
                                    }
                                 destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response)
    {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    }
                           completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error)
    {
        if(error)
        {
            NSLog(@"download error ");
            [downloadphoto downloadFailed: [error localizedDescription]];
        }
        else
        {
            NSLog(@"download success ");
            [downloadphoto  downloadSuccess:[filePath absoluteString]];
            // save
            [FileOperationManager saveFileToPhotoAlbum:filePath complete: ^(BOOL success, NSError* error)
             {
                 if(error)
                 {
                     NSLog(@"%@", [@"save failed: " stringByAppendingString:[error localizedDescription]]);
                 }
             }];
        }
    }];
}

#pragma mark add ／ remove
-(void)addToDownload: (DownloadPhoto*) download
{
    [_downloadPhotos insertObject:download atIndex:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:DownloadPhotosChangedNotification object:self];
}

-(void)removeFromDownload: (DownloadPhoto*) download
{
    [_downloadPhotos removeObject:download];
    [[NSNotificationCenter defaultCenter] postNotificationName:DownloadPhotosChangedNotification object:self];
}

@end
