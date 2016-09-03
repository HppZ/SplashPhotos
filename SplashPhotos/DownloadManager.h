//
//  DownloadManager.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/5.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadPhoto.h"

@interface DownloadManager : NSObject

+ (DownloadManager*)sharedInstance;

-(void)requestDownload: (Photo*) photo;
-(void)restartDownload: (DownloadPhoto*)downloadphoto;

@property (nonatomic, readonly) NSArray<DownloadPhoto*>* downloadedPhotos;

@end
