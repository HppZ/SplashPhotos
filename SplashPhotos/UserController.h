//
//  UserController.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserController : NSObject

-(void)getUserPublicProfile:(NSString*)username complete: (InfoRequestResultCompletionBlock) complete;

@end
