//
//  profileProfile.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/30.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UserProfile.h"
#import "Badge.h"
#import "Links.h"
#import "ProfileImage.h"

@implementation UserProfile

+(UserProfile*) fromDictionary: (NSDictionary*) dic
{
    UserProfile * profile = [[UserProfile alloc] init];
    
    profile.username = [dic objectOrNilForKey: @"username"];
    profile.name = [dic objectOrNilForKey: @"name"];
    profile.first_name = [dic objectOrNilForKey: @"first_name"];
    profile.last_name = [dic objectOrNilForKey: @"last_name"];
    profile.portfolio_url = [dic objectOrNilForKey: @"portfolio_url"];
    profile.bio = [dic objectOrNilForKey: @"bio"];
    profile.location = [dic objectOrNilForKey: @"location"];
    profile.total_likes = [[dic objectOrNilForKey: @"total_likes"] intValue];
    profile.total_photos = [[dic objectOrNilForKey: @"total_photos"] intValue];
    profile.total_collections = [[dic objectOrNilForKey: @"total_collections"] intValue];
    profile.downloads = [[dic objectOrNilForKey: @"downloads"] intValue];
    profile.profile_image = [ProfileImage fromDictionary:[dic objectOrNilForKey: @"profile_image"]];
    profile.badge = [Badge fromDictionary:[dic objectOrNilForKey: @"badge"]];
    profile.links = [Links fromDictionary:[dic objectOrNilForKey: @"links"]];
    
    return profile;
}

@end
