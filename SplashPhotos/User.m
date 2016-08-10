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

-(id)initWithName:(NSString*) name username: (NSString*)username id:(NSString*)id links: (Links*)links profileimage: (ProfileImage*)profileimage
{
    if(self = [super init])
    {
        self.name= name;
        self.username= username;
        self.id = id;
        self.links  = links;
        self.profile_image= profileimage;
    }
    return self;
}

+(User*) fromDictionary: (NSDictionary*) dic;
{
    User * user = [[User alloc] init];
    
    user.name = [dic objectForKey: @"name"];
    user.username = [dic objectForKey: @"username"];
    user.id = [dic objectForKey: @"id"];
    user.links = [Links fromDictionary:[dic objectForKey: @"links"]];
    user.profile_image = [ProfileImage fromDictionary:[dic objectForKey: @"profile_image"]];
    
    return user;
}
@end
