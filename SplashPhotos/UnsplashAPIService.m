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

#import "Category.h"
#import "Collection.h"
#import "UserProfile.h"
#import "Photo.h"

#import "GetPhotosParam.h"
#import "GetCollectionsParam.h"
#import "GetCategoriesParam.h"
#import "GetCategoryPhotosParam.h"
#import "GetCollectionPhotosParam.h"
#import "GetUserProfileParam.h"


@implementation UnsplashAPIService

static AFHTTPSessionManager *HTTPSessionManager;
static AFURLSessionManager *URLSessionManager;

+ (UnsplashAPIService*)sharedInstance
{
    static UnsplashAPIService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+(void)initialize
{
    if(self == [UnsplashAPIService class])
    {
        HTTPSessionManager = [AFHTTPSessionManager manager];
        URLSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
}

#pragma mark get

// GET /photos
-(void)GetPhotos:(GetPhotosParam*) param
 completionBlock:(APIDataRequestCompletionBlock) complete
{
    NSString * url =  [UrlHelper GetPhotosUrl];
    NSDictionary *params = [UrlHelper GetPhotosParams: param];
    
    [HTTPSessionManager GET: url parameters:params progress:nil
                    success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray* array= [NSArray arrayWithArray:responseObject];
         NSMutableArray* result = [[NSMutableArray alloc] init];
         for (id obj in array)
         {
             Photo *photo =[Photo fromDictionary: obj];
             [result addObject:photo];
         }
         complete(result, nil, nil);
     }
                    failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         complete(nil, nil, error);
     }
     ];
}

// GET /categories
-(void)GetCategories:(APIDataRequestCompletionBlock) complete
{
    NSString * url =  [UrlHelper GetCategoriesUrl];
    NSDictionary *param = [UrlHelper GetCategoriesParams];
    
    [HTTPSessionManager GET: url parameters:param progress:nil
                    success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray* array= [NSArray arrayWithArray:responseObject];
         NSMutableArray* result = [[NSMutableArray alloc] init];
         for (id obj in array)
         {
             Category *cate =[Category fromDictionary: obj];
             [result addObject:cate];
         }
         
         complete(result, nil, nil);
     }
                    failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         complete(nil, nil, error);
     }
     ];
}

// GET /categories/:id/photos
-(void)GetCategoryPhotos:(GetCategoryPhotosParam*)param
         completionBlock:(APIDataRequestCompletionBlock) complete

{
    NSString * url =  [UrlHelper GetPhotosInCategoryUrl:[param.id intValue]];
    NSDictionary *params = [UrlHelper GetPhotosInCategoryParams:param];
    
    [HTTPSessionManager GET: url parameters:params progress:nil
                    success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray* array= [NSArray arrayWithArray: responseObject];
         NSMutableArray* result = [[NSMutableArray alloc] init];
         
         for (NSDictionary * obj in array)
         {
             Photo *photo =[Photo fromDictionary: obj];
             [result addObject:photo];
         }
         complete(result, nil, nil);
         
     }
                    failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         complete(nil,nil,error);
     }
     ];
}

// GET /collections
-(void)GetCollections: (GetCollectionsParam*) param
      completionBlock:(APIDataRequestCompletionBlock) complete
{
    NSString * url =  [UrlHelper GetCollectionsUrl];
    NSDictionary *params = [UrlHelper GetCollectionsParams: param];
    
    [HTTPSessionManager GET: url parameters:params progress:nil
                    success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray* array= [NSArray arrayWithArray:responseObject];
         NSMutableArray* result = [[NSMutableArray alloc] init];
         for (id obj in array)
         {
             Collection *collection =[Collection fromDictionary: obj];
             [result addObject: collection];
         }
         
         complete(result, nil ,nil);
     }
                    failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         complete(nil,nil,error);
     }
     ];
}

// GET /collections/:id/photos
-(void)GetCollectionPhotos:(GetCollectionPhotosParam*)param
           completionBlock:(APIDataRequestCompletionBlock) complete
{
    NSString * url =  [UrlHelper GetPhotosInCollectionUrl:[param.id intValue]];
    NSDictionary *params = [UrlHelper GetPhotosInCollectionParams: param];
    
    [HTTPSessionManager GET: url parameters:params  progress:nil
                    success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray* array= [NSArray arrayWithArray:responseObject];
         NSMutableArray* result = [[NSMutableArray alloc] init];
         for (id obj in array)
         {
             Photo *collection =[Photo fromDictionary: obj];
             [result addObject: collection];
         }
         
         complete(result, nil, nil);
     }
                    failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         complete(nil,nil,error);
     }
     ];
}


// GET /users/:username
-(void)GetUserPublicProfile:(GetUserProfileParam*)param
            completionBlock:(APIInfoRequestCompletionBlock) complete
{
    NSString * url =  [UrlHelper GetUserPublicProfileUrl: param.username];
    NSDictionary *params = [UrlHelper GetUserPublicProfileParams: param];
    
    [HTTPSessionManager GET: url parameters:params progress:nil
                    success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         UserProfile * profile = [UserProfile fromDictionary:responseObject];
         complete(profile, nil);
     }
                    failure: ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     
     {
         complete(nil,error);
     }
     ];
}


#pragma mark download

- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSString*)url
                                         progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                      destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    NSURLSessionDownloadTask *downloadTask = [URLSessionManager downloadTaskWithRequest:request progress: downloadProgressBlock destination:destination completionHandler:completionHandler];
    [downloadTask resume];
    return downloadTask;
}

@end
