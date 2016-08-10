//
//  PhotosController.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface PhotoManager : NSObject

+ (id)sharedPhotoManager;

-(void)loadMoreDataWithCallback:(void(^) (NSString* errormsg)) success;
-(NSMutableArray*)getDataSource;
-(int)getCurrentPageNum;

@end
