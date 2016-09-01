//
//  UserManager.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/30.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UserManager.h"
#import "UnsplashAPIService.h"
#import "UserProfile.h"

@interface UserManager()
{
    UnsplashAPIService * _unsplashAPIService;
}

@end

@implementation UserManager

+ (id)sharedUserManager
{
    static UserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark init
-(id)init
{
    self  = [super init];
    if(self)
    {
        _unsplashAPIService = [[UnsplashAPIService alloc] init];
    }
    
    return self;
}

#pragma mark profile
-(void)getUserPublicProfileWith:(NSString*)username callback: (void (^)(UserProfile * profile, NSString* errormsg)) callback
{
    [_unsplashAPIService  GetUserPublicProfileWith:username
                                   successCallback:^(UserProfile *result)
     {
         callback(result, nil);
     }
                                     errorCallback:^(NSString *errorMsg)
     {
         callback(nil, errorMsg);
     }];
}

@end
