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

@property ( nonatomic, copy) NSString *id;
@property ( nonatomic, copy) NSString *likes;
@property ( nonatomic, copy) NSString *width;
@property ( nonatomic, copy) NSString *height;
@property ( nonatomic, copy) NSString *color;
@property ( nonatomic, copy) NSString *liked_by_user;
@property ( nonatomic, copy) NSString *created_at;
@property ( nonatomic, strong) User *user;
@property ( nonatomic, strong) Urls *urls;
@property ( nonatomic, strong) Links *links;


+(Photo*) fromDictionary: (NSDictionary*) dic;

@end

NS_ASSUME_NONNULL_END

#import "Photo+CoreDataProperties.h"
