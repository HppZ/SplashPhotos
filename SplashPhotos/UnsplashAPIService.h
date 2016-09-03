//
//  UnsplashAPIService.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Photo;
@class UserProfile;

@class GetPhotosParam;
@class GetCategoriesParam;
@class GetCollectionsParam;
@class GetCategoryPhotosParam;
@class GetCollectionPhotosParam;
@class GetUserProfileParam;

typedef void (^APIInfoRequestCompletionBlock)(_Nullable id response, NSError *_Nullable error);

typedef void (^APIDataRequestCompletionBlock)(NSArray *_Nullable data, id _Nullable response, NSError *_Nullable error);


NS_ASSUME_NONNULL_BEGIN

@interface UnsplashAPIService : NSObject

+ (UnsplashAPIService*)sharedInstance;

-(void)GetPhotos:(GetPhotosParam*) param
 completionBlock:(APIDataRequestCompletionBlock) complete;

-(void)GetCategories:(APIDataRequestCompletionBlock) complete;

-(void)GetCategoryPhotos:(GetCategoryPhotosParam*)param
         completionBlock:(APIDataRequestCompletionBlock) complete;

-(void)GetCollections: (GetCollectionsParam*) param
      completionBlock:(APIDataRequestCompletionBlock) complete;

-(void)GetCollectionPhotos:(GetCollectionPhotosParam*)param
           completionBlock:(APIDataRequestCompletionBlock) complete;

-(void)GetUserPublicProfile:(GetUserProfileParam*)param
            completionBlock:(APIInfoRequestCompletionBlock) complete;

- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSString*)url
                                         progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                      destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END