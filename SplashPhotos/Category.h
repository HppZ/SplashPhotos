//
//  Category.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Links;

@interface Category : NSObject

@property ( nonatomic, copy) NSString *id;
@property ( nonatomic, copy) NSString *title;
@property ( nonatomic, copy) NSString *photo_count;
@property ( nonatomic, strong) Links *links;

+(Category*) fromDictionary: (NSDictionary*) dic;
@end
