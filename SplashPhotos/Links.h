//
//  Links.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Links: NSObject

@property (nullable, nonatomic, copy) NSString *download;
@property (nullable, nonatomic, copy) NSString *html;
@property (nullable, nonatomic, copy) NSString *self_;

+(Links*) fromDictionary: (NSDictionary*) dic;
@end

NS_ASSUME_NONNULL_END

#import "Links+CoreDataProperties.h"
