//
//  AppStructure.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^InfoRequestResultCompletionBlock)(id _Nullable obj, NSError *_Nullable error);
typedef void (^DataRequestResultCompletionBlock)(NSArray *_Nullable data, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface AppStructure : NSObject

typedef NS_ENUM(NSInteger, PhotoSortType)
{
    PhotoSortTypeLatest,
    PhotoSortTypeOldest,
    PhotoSortTypePopular,
};

+ (NSString *)photoSortTypeName:(PhotoSortType)sortType;

@end

NS_ASSUME_NONNULL_END