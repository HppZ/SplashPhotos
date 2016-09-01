//
//  UserProfile.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/30.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Links;
@class Badge;
@class ProfileImage;

@interface UserProfile : NSObject

@property (nonatomic, copy) NSString * username ;
@property (nonatomic, copy) NSString * name ;
@property (nonatomic, copy) NSString * first_name ;
@property (nonatomic, copy) NSString * last_name ;
@property (nonatomic, copy) NSString * portfolio_url ;
@property (nonatomic, copy) NSString * bio ;
@property (nonatomic, copy) NSString * location ;
@property (nonatomic) int total_likes ;
@property (nonatomic) int total_photos ;
@property (nonatomic) int total_collections ;
@property (nonatomic) int downloads ;
@property (nonatomic, strong) ProfileImage *profile_image ;
@property (nonatomic, strong) Badge * badge ;
@property (nonatomic, strong) Links *links ;

+(UserProfile*) fromDictionary: (NSDictionary*) dic;

@end
