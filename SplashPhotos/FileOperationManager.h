//
//  FileOperationHelper.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/8.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOperationManager : NSObject

+(void)saveFileToPhotoAlbum:(NSURL*)path complete: (void(^)(BOOL success, NSError *error)) complete;

@end
