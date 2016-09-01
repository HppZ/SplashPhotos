//
//  User.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "User.h"
#import "Links.h"
#import "ProfileImage.h"

@implementation User

+(User*) fromDictionary: (NSDictionary*) dic
{
    User * user = [[User alloc] init];
    
    user.name = [dic objectOrNilForKey: @"name"];
    user.username = [dic objectOrNilForKey: @"username"];
    user.id = [dic objectOrNilForKey: @"id"];
    user.links = [Links fromDictionary:[dic objectOrNilForKey: @"links"]];
    user.profile_image = [ProfileImage fromDictionary:[dic objectOrNilForKey: @"profile_image"]];
    user.bio = [dic objectOrNilForKey: @"bio"];
    
    return user;
}
@end
