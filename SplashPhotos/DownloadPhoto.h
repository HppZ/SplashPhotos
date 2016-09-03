//
//  DownloadPhoto.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

typedef enum
{
    DownloadNotStart,
    DownloadSucceed,
    DownloadFailed,
    Downloading,
    DownloadPaused,
} DownloadState;

@interface DownloadPhoto : NSObject

@property (nonatomic, assign) DownloadState downloadState;
@property (nonatomic) float proress;
@property (nonatomic, copy) NSString* thumb;
@property (nonatomic, copy) NSString * filepath;
@property (nonatomic, copy) NSString* errormsg;
@property (nonatomic, strong) Photo * photo;

@property (nonatomic, copy, readonly) NSString* downloadUrl;

-(id)initWithPhoto: (Photo*) photo;

-(void)downloadSuccess: (NSString*)filepath;
-(void)downloadFailed: (NSString*)errormsg;
-(void)downloadingPhoto;

-(BOOL)downloadSucceed;

@end
