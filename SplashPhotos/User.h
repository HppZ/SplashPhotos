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

NS_ASSUME_NONNULL_BEGIN

@interface User: NSObject

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, strong) Links *links;
@property (nullable, nonatomic, strong) ProfileImage *profile_image;

+(User*) fromDictionary: (NSDictionary*) dic;

-(id)initWithName:(NSString*) name username: (NSString*)username id:(NSString*)id links: (Links*)links profileimage: (ProfileImage*)profileimage;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
