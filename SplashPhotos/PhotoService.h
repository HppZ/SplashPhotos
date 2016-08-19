//
//  PhotoService.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/7.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@class DownloadPhoto;

@interface PhotoService : NSObject

+(NSString*)photoSourceChangedNotification;
+(NSString*)downloadSourceChangedNotification;
+(NSString*)photosInCategoryChangedNotification;

-(NSMutableArray*)getDataSource;
-(NSMutableArray*)getDownloadDataSource;
-(NSArray*)getCategories;
-(NSMutableArray*)getPhotosInCurrentCategory;

-(void)loadMoreDataWithCallback:(void(^) (NSString* errormsg)) success;
-(void)requestDownload: (Photo*) photo;
-(void)restartDownload:(DownloadPhoto*) downloadphoto;
-(void)requestCategoriesWithCallback: (void(^) (NSString* errormsg)) success;
-(void)loadPhotosInCategoryWithName:(NSString*)name;
-(void)loadPhotosInCurrentCategoryWithCallback:(void(^) (NSString* errormsg)) success;
-(void)setCurrentCategoryWithName:(NSString*)name;

-(int)getCurrentPageNum;
-(int)getCurrentCategoryPageNum;
-(NSString*)getCurrentCategoryName;

@end
