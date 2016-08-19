//
//  Category.m
//  Splashcategorys
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "Category.h"
#import "Links2.h"

@implementation Category
+(Category*) fromDictionary: (NSDictionary*) dic
{
    Category * category  = [[Category alloc] init];
    
    category.id = [dic objectForKey: @"id"];
    category.title = [dic objectForKey: @"title"];
    category.photo_count = [dic objectForKey: @"photo_count"];
    category.links = [Links2 fromDictionary:[dic objectForKey: @"links"]];
    
    return category;
}
@end
