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
#import "CategoryManager.h"

@interface PhotoService()
{
    bool isWIFI;
    PhotoManager * photoManager;
    DownloadManager * downloadManager;
    CategoryManager* categoryManager;
}
@end

@implementation PhotoService

#pragma mark static string
+(NSString*)photoSourceChangedNotification
{
    return @"PhotoSourceChangedNotification";
}

+(NSString*)downloadSourceChangedNotification
{
    return @"DownloadSourceChangedNotification";
}

+(NSString*)photosInCategoryChangedNotification
{
    return @"photosInCategoryChangedNotification";
}


#pragma mark init
-(id)init
{
    self = [super init];
    if(self)
    {
        isWIFI = [NetworkHelper isWIFI];
        photoManager = [PhotoManager sharedPhotoManager];
        downloadManager = [DownloadManager sharedDownloadManager];
        categoryManager = [CategoryManager sharedCategoryManager];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:)
                                                     name:[NetworkHelper networkChangedNotification]
                                                   object:nil];
        
    }
    
    return self;
}

#pragma mark 网络状态
- (void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:[NetworkHelper networkChangedNotification]])
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

-(NSArray*)getCategories
{
    return [categoryManager getCategories];
}

-(NSMutableArray*)getPhotosInCurrentCategory
{
    return [categoryManager getPhotosInCurrentCategory];
}

#pragma mark 请求

#pragma mark photo & download
-(void)loadMoreDataWithCallback:(void(^) (NSString* errormsg)) success
{
    [photoManager  loadMoreDataWithCallback:
     ^(NSString* error)
     {
         if(!error)
         {
             [[NSNotificationCenter defaultCenter] postNotificationName: [PhotoService photoSourceChangedNotification] object:self];
         }
         
         success(error);
     }];
}

-(void)requestDownload: (Photo*) photo
{
    [downloadManager requestDownload:photo];
    [[NSNotificationCenter defaultCenter] postNotificationName: [PhotoService downloadSourceChangedNotification] object:self];
}

-(void)restartDownload:(DownloadPhoto*) downloadphoto
{
    [downloadManager  restartDownload:downloadphoto];
}


#pragma mark category
-(void)requestCategoriesWithCallback: (void(^) (NSString* errormsg)) success
{
    [categoryManager loadCategories:^(NSString *error)
     {
         success(error);
    }];
}

-(void)loadPhotosInCategoryWithName:(NSString*)name
{
    [categoryManager loadPhotosInCategoryWithName:name
                                          success:^(NSString* error)
    {
        if(!error)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName: [PhotoService photosInCategoryChangedNotification] object:self];
        }

    }];
}

-(void)loadPhotosInCurrentCategoryWithCallback:(void(^) (NSString* errormsg)) success
{
    [categoryManager loadPhotosInCurrentCategoryWithCallback:^(NSString *errormsg)
    {
        if(!errormsg)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName: [PhotoService photosInCategoryChangedNotification] object:self];
        }
       
        success(errormsg);
    }];
}

-(void)setCurrentCategoryWithName:(NSString*)name
{
    [categoryManager setCurrentCategoryWithName:name];
}


#pragma mark get info
-(int)getCurrentPageNum
{
    return [photoManager getCurrentPageNum];
}

-(int)getCurrentCategoryPageNum
{
    return [categoryManager getCurrentCategoryPage];
}

-(NSString*)getCurrentCategoryName
{
    return [categoryManager  getCurrentCategoryName];
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
