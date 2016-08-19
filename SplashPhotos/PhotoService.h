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

-(NSMutableArray*)getDataSource;
-(NSMutableArray*)getDownloadDataSource;
-(NSArray*)getCategories;

-(void)loadMoreDataWithCallback:(void(^) (NSString* errormsg)) success;
-(void)requestDownload: (Photo*) photo;
-(void)restartDownload:(DownloadPhoto*) downloadphoto;
-(void)requestCategoriesWithCallback: (void(^) (NSString* errormsg)) success;
-(void)loadPhotosInCategoryWithName:(NSString*)name;

-(int)getCurrentPageNum;

@end
