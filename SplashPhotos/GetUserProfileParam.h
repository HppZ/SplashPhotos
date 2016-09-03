//
//  GetUserProfileParam.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetUserProfileParam : NSObject

@property (nonatomic, copy) NSString* username;
@property (nonatomic) NSInteger w;
@property (nonatomic) NSInteger h;

-(id)initWithName: (NSString*) username   w: (NSInteger) w h: (NSInteger) h;

@end
