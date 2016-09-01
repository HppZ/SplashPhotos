//
//  PhotoService.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/7.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@class UserProfile;
@class DownloadPhoto;

@interface PhotoService : NSObject

// notification
+(NSString*)photoSourceChangedNotification;
+(NSString*)downloadSourceChangedNotification;
+(NSString*)photosInCategoryChangedNotification;
+(NSString*)collectionsChangedNotification;

// source
-(NSMutableArray*)getDataSource;
-(NSMutableArray*)getDownloadDataSource;
-(NSArray*)getCategories;
-(NSMutableArray*)getPhotosInCategoryWithName:(NSString*) name;
-(NSMutableArray*)getCollections;

// load
-(void)loadMoreDataWithCallback:(void(^) (NSString* errormsg)) success;
-(void)requestDownload: (Photo*) photo;
-(void)restartDownload:(DownloadPhoto*) downloadphoto;
-(void)requestCategoriesWithCallback: (void(^) (NSString* errormsg)) success;
-(void)loadPhotosInCategoryWithName:(NSString*)name callback: (void(^) (NSString* errormsg)) callback;
-(void)loadMoreCollectionsWithCallbak : (void(^) (NSString* errormsg)) callback;
-(void)loadUserPublicProfile: (NSString*)userName callback: ( void(^)(UserProfile *profile, NSString *errormsg)) callback;

//
-(int)getCurrentPageNum;
-(int)getCategoryPageWithName: (NSString*)name;
-(int)getCollectionsPageNum;


@end
