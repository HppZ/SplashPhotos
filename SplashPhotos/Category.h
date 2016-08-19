//
//  Category.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Links2;

@interface Category : NSObject

@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *photo_count;
@property (nullable, nonatomic, strong) Links2 *links;


+(Category*) fromDictionary: (NSDictionary*) dic;
@end
