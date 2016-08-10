//
//  DownloadPhoto.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"


@interface DownloadPhoto : NSObject

@property (nonatomic, copy) NSString* thumb;
@property (nonatomic, strong) Photo * photo;
@property (nonatomic, copy) NSString * filepath;
@property (nonatomic) float proress;
@property (nonatomic) BOOL isCompleted;

-(id)initWithPhoto: (Photo*) photo;

@end
