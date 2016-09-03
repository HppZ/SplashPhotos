//
//  SplashControllerAccess.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhotoController;
@class CollectionController;
@class UserController;
@class CategoryController;

@interface SplashControllerAccess : NSObject

+(PhotoController*) photoController;
+(CollectionController*) collectionController;
+(UserController*) userController;
+(CategoryController*) categoryController;

@end
