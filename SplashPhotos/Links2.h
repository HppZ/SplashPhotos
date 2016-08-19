//
//  Links2.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Links2 : NSObject

@property (nullable, nonatomic, copy) NSString *self_;
@property (nullable, nonatomic, copy) NSString *photos;


+(Links2*) fromDictionary: (NSDictionary*) dic;
@end
