//
//  NetworkRequestHelper.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "NetworkRequestHelper.h"
#import "AFNetworking.h"

@interface NetworkRequestHelper()
{

}
@end

@implementation NetworkRequestHelper

static AFHTTPSessionManager *HTTPSessionManager;
static AFURLSessionManager *URLSessionManager;

+(void)initialize
{
    if(self == [NetworkRequestHelper class])
    {
        HTTPSessionManager = [AFHTTPSessionManager manager];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        URLSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
}

#pragma mark http get
+(void)GETWithUrl: (nonnull NSString*) url
    andParameters: (nullable NSDictionary*) parameters
  successCallback: (nullable void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)) successCallback
    errorCallback: (nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)) errorCallback
{
    [HTTPSessionManager GET: url parameters:
     parameters progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         successCallback(task ,responseObject);
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         errorCallback(task, error);
     }];
}

#pragma mark download
+(void)DownloadWithUrl:(NSString*) url
   ProgressCallback: (nullable void (^)(NSProgress* _Nonnull downloadprogress)) progress
    completionCallback:(nullable void(^)( NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error)) complete
{
    NSURL *URL = [NSURL URLWithString: url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask =
    [URLSessionManager downloadTaskWithRequest:request
     progress:^(NSProgress* downloadprogress)
     {
         progress(downloadprogress);
     }
     destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
     {
         NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
         return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
     }
     completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error)
     {
         NSLog(@"networkhelper complete ");
         complete(response, filePath, error);
     }];
    
    [downloadTask resume];
}

@end
