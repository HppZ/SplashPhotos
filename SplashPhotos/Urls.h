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

@property ( nonatomic, copy) NSString *full;
@property ( nonatomic, copy) NSString *raw;
@property ( nonatomic, copy) NSString *regular;
@property ( nonatomic, copy) NSString *small;
@property ( nonatomic, copy) NSString *thumb;


+(Urls*) fromDictionary: (NSDictionary*) dic;
@end

NS_ASSUME_NONNULL_END

#import "Urls+CoreDataProperties.h"
