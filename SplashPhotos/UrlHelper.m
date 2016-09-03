//
//  UnsplashAPI.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UrlHelper.h"

#import "GetPhotosParam.h"
#import "GetCollectionsParam.h"
#import "GetCategoriesParam.h"
#import "GetCategoryPhotosParam.h"
#import "GetCollectionPhotosParam.h"
#import "GetUserProfileParam.h"

@implementation UrlHelper

+(NSString*)Unsplash
{
    return @"https://unsplash.com/";
}

+(NSString*)Host
{
    return @"https://api.unsplash.com";
}

+(NSString*)AppID
{
    return @"df98b7ef42f7084d03867232818a474ffa0967522019cf8a3fb432a2f1d44718";
}

+(NSString*)SecretKey
{
    return @"d8bf6a79566897b00887dd0327a9a7cc5f1ca6cec4c0b44abe509faa91cb9776";
}

#pragma mark urls
+(NSString*)GetPhotosUrl
{
    return [self GetUrlHelper: @"/photos"];
}

+(NSString*)GetCategoriesUrl
{
    return [self GetUrlHelper: @"/categories"];
}

+(NSString*)GetPhotosInCategoryUrl:(int)id
{
    NSString* p = [NSString  stringWithFormat:@"%@%d%@", @"/categories/", id, @"/photos"];
    return [self GetUrlHelper: p];
}

+(NSString*) GetCollectionsUrl
{
    return [self GetUrlHelper: @"/collections"];
}

+(NSString*) GetPhotosInCollectionUrl:(int)id
{
    NSString* p = [NSString  stringWithFormat:@"%@%d%@", @"/collections/", id, @"/photos"];
    return [self GetUrlHelper:p];
}

+(NSString*)GetUserPublicProfileUrl:(NSString *)username
{
    NSString* p = [NSString  stringWithFormat:@"%@%@", @"/users/", username];
    return [self GetUrlHelper:p];
}

#pragma mark params

// 照片列表
+(NSDictionary*)GetPhotosParams: (GetPhotosParam*) p
{
    NSDictionary *param = [[NSDictionary alloc]
                           initWithObjectsAndKeys:
                           [NSNumber numberWithInteger: p.page]  , @"page",
                           [NSNumber numberWithInteger: p.perPage],  @"per_page",
                           [AppStructure photoSortTypeName: p.orderBy],  @"order_by",
                           nil];
    
    return param;
}

// 分类列表
+(NSDictionary*)GetCategoriesParams
{
    NSDictionary *param = [[NSDictionary alloc]init];
    return param;
}

// 分类中的照片
+(NSDictionary*)GetPhotosInCategoryParams:(GetCategoryPhotosParam*) p
{
    NSDictionary *param = [[NSDictionary alloc]
                           initWithObjectsAndKeys:
                           p.id, @"id",
                           [NSNumber numberWithInteger:p.page], @"page",
                           [NSNumber numberWithInteger: p.perPage],  @"per_page",
                           nil];
    return param;
}

+(NSDictionary*) GetCollectionsParams:(GetCollectionsParam*)p
{
    NSDictionary *param = [[NSDictionary alloc]
                           initWithObjectsAndKeys:
                           [NSNumber numberWithInteger: p.page], @"page",
                           [NSNumber numberWithInteger: p.perPage],  @"per_page",
                           nil];
    return param;
}

+(NSDictionary*)GetPhotosInCollectionParams: (GetCollectionPhotosParam*)p
{
    NSDictionary *param = [[NSDictionary alloc]
                           initWithObjectsAndKeys:
                           p.id, @"id",
                           [NSNumber numberWithInteger: p.page], @"page",
                           [NSNumber numberWithInteger: p.perPage],  @"per_page",
                           nil];
    return param;

}

+(NSDictionary*) GetUserPublicProfileParams:(GetUserProfileParam *)p
{
    NSDictionary *param = [[NSDictionary alloc]
                           initWithObjectsAndKeys:
                           p.username, @"username",
                           [NSNumber numberWithInteger: p.w], @"w",
                           [NSNumber numberWithInteger: p.h],  @"h",
                           nil];
    return param;
}



// helper
+(NSString*)GetUrlHelper:(id)param
{
    return [NSString  stringWithFormat:@"%@%@%@%@", self.Host, param , @"?client_id=", self.AppID];
}

+(int)randomNum
{
    return arc4random() % 1024;
}


@end
