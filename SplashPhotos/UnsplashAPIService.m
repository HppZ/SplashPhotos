//
//  UnsplashAPIService.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UnsplashAPIService.h"
#import "UrlHelper.h"
#import "AFNetworking.h"
#import "NetworkHelper.h"
#import "NetworkRequestHelper.h"
#import "Category.h"
#import "Collection.h"
#import "UserProfile.h"


@implementation UnsplashAPIService

#pragma mark get
// GET /photos
-(void)GetPhotosWithPageNum:(int) num
            successCallback:(void (^)(NSArray * photos)) resultCallback
              errorCallback:(void (^)(NSString *errorMsg)) errorCallback

{
    NSString * url =  [UrlHelper GetPhotosUrl];
    NSDictionary *param = [UrlHelper GetPhotosParamsWithPageNum: num];
    
    [NetworkRequestHelper GETWithUrl: url andParameters:param
                     successCallback: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray* array= [NSArray arrayWithArray:responseObject];
         NSMutableArray* result = [[NSMutableArray alloc] init];
         for (id obj in array)
         {
             Photo *photo =[Photo fromDictionary: obj];
             [result addObject:photo];
         }
         resultCallback(result);
         
     }
                       errorCallback: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         errorCallback([error localizedDescription]);
     }
     ];
    
}

// GET /categories
-(void)GetCategoriesWithsuccessCallback:(void (^)(NSArray * categories)) resultCallback
                          errorCallback:(void (^)(NSString * errorMsg)) errorCallback
{
    NSString * url =  [UrlHelper GetCategoriesUrl];
    NSDictionary *param = [UrlHelper GetCategoriesParams];
    
    [NetworkRequestHelper GETWithUrl: url andParameters:param
                     successCallback: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray* array= [NSArray arrayWithArray:responseObject];
         NSMutableArray* result = [[NSMutableArray alloc] init];
         for (id obj in array)
         {
             Category *cate =[Category fromDictionary: obj];
             [result addObject:cate];
         }
         
         resultCallback(result);
     }
                       errorCallback: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         errorCallback([error localizedDescription]);
     }
     ];
}

// GET /categories/:id/photos
-(void)GetPhotosInCategoryWithID: (int)categoryID
                    page:(int) num
            successCallback:(void (^)(NSArray * photos)) resultCallback
              errorCallback:(void (^)(NSString *errorMsg)) errorCallback

{
    NSString * url =  [UrlHelper GetPhotosInCategoryUrl:categoryID];
    NSDictionary *param = [UrlHelper GetPhotosInCategoryParamsWithID:categoryID page:num];
    
    [NetworkRequestHelper GETWithUrl: url andParameters:param
                     successCallback: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray* array= [NSArray arrayWithArray: responseObject];
         NSMutableArray* result = [[NSMutableArray alloc] init];
         
         for (NSDictionary * obj in array)
         {
             Photo *photo =[Photo fromDictionary: obj];
             [result addObject:photo];
         }
         resultCallback(result);
         
     }
                       errorCallback: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         errorCallback([error localizedDescription]);
     }
     ];
    
}

// GET /collections
-(void)GetCollectionsWithPage: (int) num
              successCallback:(void (^)(NSArray * result)) resultCallback
                errorCallback:(void (^)(NSString *errorMsg)) errorCallback
{
    NSString * url =  [UrlHelper GetCollectionsUrl];
    NSDictionary *param = [UrlHelper GetCollectionsParamsWithPage:num];
    
    [NetworkRequestHelper GETWithUrl: url andParameters:param
                     successCallback: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray* array= [NSArray arrayWithArray:responseObject];
         NSMutableArray* result = [[NSMutableArray alloc] init];
         for (id obj in array)
         {
             Collection *collection =[Collection fromDictionary: obj];
             [result addObject: collection];
         }
         
         resultCallback(result);
     }
                       errorCallback: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         errorCallback([error localizedDescription]);
     }
     ];
}

// GET /collections/:id/photos
-(void)GetPhotosInCollectionWith:(int)collectionID
                            page: (int)page
                successCallback:(void (^)(NSArray * result)) resultCallback
                  errorCallback:(void (^)(NSString *errorMsg)) errorCallback
{
    NSString * url =  [UrlHelper GetPhotosInCollectionUrl:collectionID];
    NSDictionary *param = [UrlHelper GetPhotosInCollectionParamsWithID:collectionID page:page];
    
    [NetworkRequestHelper GETWithUrl: url andParameters:param
                     successCallback: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray* array= [NSArray arrayWithArray:responseObject];
         NSMutableArray* result = [[NSMutableArray alloc] init];
         for (id obj in array)
         {
             Photo *collection =[Photo fromDictionary: obj];
             [result addObject: collection];
         }
         
         resultCallback(result);
     }
                       errorCallback: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         errorCallback([error localizedDescription]);
     }
     ];
}


// GET /users/:username
-(void)GetUserPublicProfileWith:(NSString*)username
                successCallback:(void (^)(UserProfile * result)) resultCallback
                  errorCallback:(void (^)(NSString *errorMsg)) errorCallback
{
    NSString * url =  [UrlHelper GetUserPublicProfileUrl:username];
    NSDictionary *param = [UrlHelper GetUserPublicProfileParamsWithUsername:username];
    
    [NetworkRequestHelper GETWithUrl: url andParameters:param
                     successCallback: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         UserProfile * profile = [UserProfile fromDictionary:responseObject];
         resultCallback(profile);
     }
                       errorCallback: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         errorCallback([error localizedDescription]);
     }
     ];
}


//----------------------------------------------------------

#pragma mark download
// Download photo
-(void)DownloadWithUrl: (NSString*)url
      progressCallback: ( void(^)(float value) ) progress
      completeCallback:( void (^)(NSURL *filePath, NSString* errormsg)) complete ;
{
    [NetworkRequestHelper DownloadWithUrl:url
                         ProgressCallback: ^(NSProgress* downloadprogress)
     {
         progress(downloadprogress.fractionCompleted);
     }
                       completionCallback:^(NSURLResponse *response, NSURL *filePath, NSError *error)
     {
         NSLog(@"download api complete ");
         complete(filePath, [error localizedDescription]);
     }];
}

@end
