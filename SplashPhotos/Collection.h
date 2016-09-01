//
//  Collection
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
@class CoverPhoto;

@interface Collection : NSObject

@property (nonatomic, copy) NSString *  id ;
@property (nonatomic, copy) NSString * title ;
@property (nonatomic, copy) NSString * description_ ;
@property (nonatomic) NSDate * published_at ;
@property (nonatomic) bool curated ;
@property (nonatomic, copy) NSString * total_photos ;
@property (nonatomic) bool private_ ;
@property (nonatomic, copy) NSString * share_key ;
@property (nonatomic) CoverPhoto * cover_photo ;
@property (nonatomic) User * user ;
@property (nonatomic) Links * links ;


+(Collection*) fromDictionary: (NSDictionary*) dic;

@end
