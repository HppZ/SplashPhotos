//
//  NetworkRequestHelper.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequestHelper : NSObject

+(void)GETWithUrl: (nonnull NSString*) url
    andParameters: (nullable NSDictionary*) parameters
  successCallback: (nullable void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)) successCallback
    errorCallback: (nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)) errorCallback;

+(void)DownloadWithUrl:(nonnull NSString*) url
      ProgressCallback: (nullable void (^)(NSProgress* _Nonnull downloadprogress)) progress
    completionCallback:(nullable void(^)( NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error)) complete;

@end
