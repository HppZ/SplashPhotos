//
//  DownloadManager.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/5.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadManager.h"
#import "UnsplashAPIHelper.h"
#import "Urls.h"
#import "FileOperationManager.h"

@interface DownloadManager ()
{
    NSMutableArray<DownloadPhoto*>* _downloadPhotos;
    UnsplashAPIHelper* _unsplashAPIHelper;
}
@end

@implementation DownloadManager
#pragma mark 单例
+ (id)sharedDownloadManager
{
    static DownloadManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        _downloadPhotos = [[NSMutableArray<DownloadPhoto*> alloc] init];
        _unsplashAPIHelper = [[UnsplashAPIHelper alloc] init];
    }
    
    return self;
}

#pragma mark public
-(NSMutableArray*)getDownloadDataSource
{
    return _downloadPhotos;
}

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
    NSLog(@"start download");
    [downloadphoto downloadingPhoto];
    [_unsplashAPIHelper DownloadWithUrl:[downloadphoto.photo.urls raw]
                       progressCallback:^(float value)
     {
         [downloadphoto setProress:value];
     }
                       completeCallback: ^(NSURL* filepath, NSString* errormsg)
     {
         if(errormsg)
         {
             NSLog(@"start download error ");
             [downloadphoto downloadFailed: errormsg];
         }
         else
         {
             NSLog(@"start download no error ");
             // downloaded
             [downloadphoto  downloadSuccess:[filepath absoluteString]];
             
             // and save
             [FileOperationManager saveFileToPhotoAlbum:filepath complete: ^(BOOL success, NSError* error)
              {
                  if(!error)
                  {
                      NSLog(@"save success");
                  }
                  else
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
}

-(void)removeFromDownload: (DownloadPhoto*) download
{
    [_downloadPhotos removeObject:download];
}

@end
