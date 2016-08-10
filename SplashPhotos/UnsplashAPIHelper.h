//
//  UnsplashAPIHelper.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface UnsplashAPIHelper : NSObject

-(void)GetPhotosWithPageNum:(int) num
            successCallback:(void (^)(NSArray * photos)) resultCallback
              errorCallback:(void (^)(NSString *errorMsg)) errorCallback;

-(void)DownloadWithUrl: (NSString*)url progressCallback: ( void(^)(float value) ) progress completeCallback:( void (^)(NSURL *filePath, NSString* errormsg)) complete ;

@end
