//
//  Urls.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Urls: NSObject

@property (nullable, nonatomic, copy) NSString *full;
@property (nullable, nonatomic, copy) NSString *raw;
@property (nullable, nonatomic, copy) NSString *regular;
@property (nullable, nonatomic, copy) NSString *small;
@property (nullable, nonatomic, copy) NSString *thumb;


+(Urls*) fromDictionary: (NSDictionary*) dic;
@end

NS_ASSUME_NONNULL_END

#import "Urls+CoreDataProperties.h"
