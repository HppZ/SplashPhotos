//
//  UnsplashAPIHelper.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UnsplashAPIHelper.h"
#import "UrlHelper.h"
#import "AFNetworking.h"
#import "NetworkHelper.h"
#import "Photo.h"
#import "NetworkRequestHelper.h"

@implementation UnsplashAPIHelper

#pragma mark get
// GET /photos
-(void)GetPhotosWithPageNum:(int) num
            successCallback:(void (^)(NSArray * photos)) resultCallback
              errorCallback:(void (^)(NSString *errorMsg)) errorCallback

{
    NSString * url =  [UrlHelper GetPhotosUrl];
    NSDictionary *param = [UrlHelper GetPhotosParamsWithPageNum:num];
    
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
         complete(filePath, [error localizedDescription]);
     }];
}

@end
