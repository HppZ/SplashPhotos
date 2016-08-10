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

// params
+(NSDictionary*)GetPhotosParamsWithPageNum: (NSInteger) num;

@end
