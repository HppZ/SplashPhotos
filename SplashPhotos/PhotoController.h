//
//  PhotoController.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Photo;
@class DownloadPhoto;

@interface PhotoController : NSObject

-(void)loadPhotos: (NSInteger) page complete: (DataRequestResultCompletionBlock) complete;
-(void)requestDownload: (Photo*) photo;
-(NSArray*)getDownloadPhotos;
-(void)restartDownload: (DownloadPhoto*)downloadphoto;

@end
