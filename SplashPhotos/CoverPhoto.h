//
//  CoverPhoto.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Urls;
@class User;
@class Category;
@class Links;

@interface CoverPhoto : NSObject

@property   (nonatomic, copy) NSString * id;
@property   (nonatomic, copy) NSString * width;
@property   (nonatomic, copy) NSString * height;
@property   (nonatomic, copy) NSString * color;
@property   (nonatomic, copy) NSString * likes;
@property   (nonatomic) bool liked_by_user;
@property   (nonatomic, strong) User * user;
@property   (nonatomic, strong) Urls * urls;
@property   (nonatomic, strong) NSArray<Category*> * categories;
@property   (nonatomic, strong) Links * links;


+(CoverPhoto*) fromDictionary: (NSDictionary*) dic;

@end
