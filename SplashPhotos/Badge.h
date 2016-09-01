//
//  Badge.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/30.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Badge : NSObject

@property (nonatomic, copy) NSString* title ;
@property (nonatomic) bool primary ;
@property (nonatomic, copy) NSString* slug ;
@property (nonatomic, copy) NSString* link ;

+(Badge*) fromDictionary: (NSDictionary*) dic;

@end
