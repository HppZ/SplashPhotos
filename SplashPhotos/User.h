//
//  User.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Links, ProfileImage;

@interface User: NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) Links *links;
@property (nonatomic, strong) ProfileImage *profile_image;
@property (nonatomic, strong) NSString *bio;

+(User*) fromDictionary: (NSDictionary*) dic;

@end

#import "User+CoreDataProperties.h"
