//
//  NSString+stringIsNilOrEmpty.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/31.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "NSString+stringIsNilOrEmpty.h"

#define Trim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

@implementation NSString (stringIsNilOrEmpty)

+(BOOL)stringIsNilOrEmpty:(NSString*) str
{
   return !str && [Trim(str) length] == 0;
}


@end
