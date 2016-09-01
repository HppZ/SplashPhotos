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
#import "CollectionManager.h"
#import "UserManager.h"

@class UserProfile;

@interface PhotoService()
{
    bool isWIFI;
    PhotoManager * photoManager;
    DownloadManager * downloadManager;
    CategoryManager* categoryManager;
    CollectionManager * collectionManager;
    UserManager * userManager;
}
@end

@implementation PhotoService

#pragma mark notification
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

+(NSString*)collectionsChangedNotification
{
    return @"collectionsChangedNotification";
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
        collectionManager = [CollectionManager sharedCollectionManager];
        userManager = [UserManager sharedUserManager];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:)
                                                     name:[NetworkHelper networkChangedNotification]
                                                   object:nil];
        
    }
    
    return self;
}

#pragma mark network state
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

#pragma mark source
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

-(NSMutableArray*)getPhotosInCategoryWithName:(NSString*) name
{
    return [categoryManager getPhotosInCategoryWithName:name];
}

-(NSMutableArray*)getCollections
{
    return [collectionManager getCollections];
}

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

-(void)loadPhotosInCategoryWithName:(NSString*)name callback: (void(^) (NSString* errormsg)) callback
{
    [categoryManager loadPhotosInCategoryWithName:name
                                          success:^(NSString* error)
    {
        if(!error)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName: [PhotoService photosInCategoryChangedNotification] object:self];
        }
        callback(error);
    }];
}

#pragma mark collections
-(void)loadMoreCollectionsWithCallbak : (void(^) (NSString* errormsg)) callback
{
    [collectionManager loadMoreCollectionsWithCallback:
     ^(NSString *errormsg) {
         if(!errormsg)
         {
             [[NSNotificationCenter defaultCenter] postNotificationName: [PhotoService collectionsChangedNotification] object:self];
         }
         
         callback(errormsg);
    }];
}

#pragma user
-(void)loadUserPublicProfile: (NSString*)userName callback: ( void(^)(UserProfile *profile, NSString *errormsg)) callback
{
    [userManager getUserPublicProfileWith:userName callback:callback];
}


#pragma mark page info
-(int)getCurrentPageNum
{
    return [photoManager getCurrentPageNum];
}

-(int)getCategoryPageWithName: (NSString*)name
{
    return [categoryManager getCategoryPageWithName:name];
}

-(int)getCollectionsPageNum
{
    return [collectionManager getCurrentPageNum];
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
