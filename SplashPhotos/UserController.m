//
//  UserController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UserController.h"
#import "UnsplashAPIService.h"
#import "GetUserProfileParam.h"

@interface UserController()
{
    UnsplashAPIService * _apiService;
}
@end

@implementation UserController


#pragma mark init
-(id)init
{
    self  = [super init];
    if(self)
    {
        _apiService = [UnsplashAPIService sharedInstance];
    }
    return self;
}

#pragma mark profile
-(void)getUserPublicProfile:(NSString*)username complete: (InfoRequestResultCompletionBlock) complete
{
    GetUserProfileParam* param = [[GetUserProfileParam alloc]initWithName:username w:0 h:0];
    
    [_apiService GetUserPublicProfile:param
                      completionBlock:^(id  _Nullable response, NSError * _Nullable error)
     {
         complete(response, error);
     }];
}

@end
