//
//  UnsplashAPI.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetPhotosParam;
@class GetCategoriesParam;
@class GetCollectionsParam;
@class GetCategoryPhotosParam;
@class GetCollectionPhotosParam;
@class GetUserProfileParam;

@interface UrlHelper : NSObject

+(NSString*) Host;
+(NSString*) AppID;
+(NSString*) SecretKey;
+(NSString*) Unsplash;

// urls
+(NSString*) GetPhotosUrl;
+(NSString*) GetCategoriesUrl;
+(NSString*) GetPhotosInCategoryUrl:(int)id;
+(NSString*) GetCollectionsUrl;
+(NSString*) GetPhotosInCollectionUrl: (int)id;
+(NSString*) GetUserPublicProfileUrl: (NSString*)username;

// params
+(NSDictionary*)GetPhotosParams: (GetPhotosParam*) p;
+(NSDictionary*)GetCategoriesParams;
+(NSDictionary*)GetPhotosInCategoryParams:(GetCategoryPhotosParam*) p;
+(NSDictionary*) GetCollectionsParams:(GetCollectionsParam*)p;
+(NSDictionary*)GetPhotosInCollectionParams: (GetCollectionPhotosParam*)p;
+(NSDictionary*) GetUserPublicProfileParams:(GetUserProfileParam *)p;

@end
