//
//  SplashControllerAccess.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "SplashControllerAccess.h"
#import "PhotoController.h"
#import "CollectionController.h"
#import "UserController.h"
#import "CategoryController.h"

@interface SplashControllerAccess ()
{
}
@end

@implementation SplashControllerAccess

static PhotoController* _photoController;
static CollectionController*  _collectionController;
static UserController*  _userController;
static CategoryController*  _categoryController;

+(void)initialize
{
    if(self == [SplashControllerAccess class])
    {
        _photoController  = [PhotoController new];
        _collectionController  = [CollectionController new];
        _userController  = [UserController new];
        _categoryController  = [CategoryController new];
    }
}

+(PhotoController*) photoController
{
    return _photoController;
}

+(CollectionController*) collectionController
{
    return _collectionController;
}

+(UserController*) userController
{
    return _userController;
}

+(CategoryController*) categoryController
{
    return _categoryController;
}

@end
