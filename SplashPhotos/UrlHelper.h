//
//  UnsplashAPI.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlHelper : NSObject

+(NSString*) Host;
+(NSString*) AppID;
+(NSString*) SecretKey;
+(NSString*) Unsplash;

// urls
+(NSString*) GetPhotosUrl;
+(NSString*) GetCategoriesUrl;
+(NSString*) GetPhotosInCategoryUrl:(int)id;


// params
+(NSDictionary*) GetPhotosParamsWithPageNum: (int) num;
+(NSDictionary*) GetCategoriesParams;
+(NSDictionary*) GetPhotosInCategoryParamsWithID: (int) id page: (int) num;

@end
