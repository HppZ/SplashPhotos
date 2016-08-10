//
//  NetworkRequestHelper.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequestHelper : NSObject

+(void)GETWithUrl: (NSString*) url
    andParameters: (NSDictionary*) parameters
  successCallback: (void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)) successCallback
    errorCallback: (void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)) errorCallback;

+(void)DownloadWithUrl:(NSString*) url
      ProgressCallback: (void (^)(NSProgress* downloadprogress)) progress
    completionCallback:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error)) complete;

@end
