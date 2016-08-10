//
//  Photo.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"
#import "Links.h"


@class Urls;

NS_ASSUME_NONNULL_BEGIN

@interface Photo: NSObject

@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *likes;
@property (nullable, nonatomic, copy) NSString *width;
@property (nullable, nonatomic, copy) NSString *height;
@property (nullable, nonatomic, copy) NSString *color;
@property (nullable, nonatomic, copy) NSString *liked_by_user;
@property (nullable, nonatomic, copy) NSString *created_at;
@property (nullable, nonatomic, strong) User *user;
@property (nullable, nonatomic, strong) Urls *urls;
@property (nullable, nonatomic, strong) Links *links;


+(Photo*) fromDictionary: (NSDictionary*) dic;

@end

NS_ASSUME_NONNULL_END

#import "Photo+CoreDataProperties.h"
