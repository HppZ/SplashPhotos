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

@property ( nonatomic, copy) NSString *download;
@property ( nonatomic, copy) NSString *html;
@property ( nonatomic, copy) NSString *self_;
@property ( nonatomic, copy) NSString *photos;
@property (nonatomic, strong) NSString *likes;
@property (nonatomic, strong) NSString *related;

+(Links*) fromDictionary: (NSDictionary*) dic;
@end

NS_ASSUME_NONNULL_END

#import "Links+CoreDataProperties.h"
