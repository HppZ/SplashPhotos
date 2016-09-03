//
//  AppStructure.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "AppStructure.h"

@implementation AppStructure

+ (NSDictionary *)photoSortTypeAPINames
{
    return @{@(PhotoSortTypeLatest)  : @"latest",
             @(PhotoSortTypeOldest)  : @"oldest",
             @(PhotoSortTypePopular) : @"popular"
             };
}

+ (NSString *)photoSortTypeName:(PhotoSortType)sortType
{
    NSDictionary *names = [self photoSortTypeAPINames];
    return sortType < names.count ? names[@(sortType)] : nil;
}

@end
