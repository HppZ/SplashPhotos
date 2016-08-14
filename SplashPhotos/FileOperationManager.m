//
//  FileOperationHelper.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/8.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "FileOperationManager.h"
#import <UIKit/UIKit.h>

@import Photos;

@implementation FileOperationManager

+(void)saveFileToPhotoAlbum:(NSURL*)path complete: (void(^)(BOOL success, NSError *error)) complete
{
    NSString*  p =  [[[path absoluteString] componentsSeparatedByString:@"///"] objectAtIndex:1];
    UIImage *viewImage = [UIImage imageWithContentsOfFile: p];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage: viewImage];
    } completionHandler: complete];
}

@end
