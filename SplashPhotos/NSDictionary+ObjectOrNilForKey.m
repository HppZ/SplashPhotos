//
//  NSDictionary+ObjectOrNilForKey.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/30.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "NSDictionary+ObjectOrNilForKey.h"

@implementation NSDictionary (ObjectOrNilForKey)

- (id)objectOrNilForKey:(id)key
{
    id object = [self objectForKey:key];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
