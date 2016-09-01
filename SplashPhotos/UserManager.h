//
//  UserManager.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/30.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserProfile;

@interface UserManager : NSObject

+ (id)sharedUserManager;

-(void)getUserPublicProfileWith:(NSString*)username callback: (void (^)(UserProfile * profile, NSString* errormsg)) callback;

@end
