//
//  Category.m
//  Splashcategorys
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "Category.h"
#import "Links.h"

@implementation Category

+(Category*) fromDictionary: (NSDictionary*) dic
{
    Category * category  = [[Category alloc] init];
    
    category.id = [dic objectOrNilForKey: @"id"];
    category.title = [dic objectOrNilForKey: @"title"];
    category.photo_count = [dic objectOrNilForKey: @"photo_count"];
    category.links = [Links fromDictionary:[dic objectOrNilForKey: @"links"]];
    
    return category;
}

@end
