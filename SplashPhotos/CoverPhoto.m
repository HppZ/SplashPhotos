//
//  CoverPhoto.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CoverPhoto.h"
#import "User.h"
#import "Links.h"
#import "Urls.h"
#import "Category.h"


@implementation CoverPhoto

+(CoverPhoto*) fromDictionary: (NSDictionary*) dic
{
    CoverPhoto * coverphoto = [[CoverPhoto alloc]init];
    
    coverphoto.id = [dic objectOrNilForKey:@"id"];
    coverphoto.width = [dic objectOrNilForKey:@"width"];
    coverphoto.height = [dic objectOrNilForKey:@"height"];
    coverphoto.color = [dic objectOrNilForKey:@"color"];
    coverphoto.likes = [dic objectOrNilForKey:@"likes"];
    coverphoto.liked_by_user = [dic objectOrNilForKey:@"liked_by_user"];
    coverphoto.user = [User fromDictionary:[dic objectOrNilForKey:@"user"]];
    coverphoto.urls = [Urls fromDictionary:[dic objectOrNilForKey:@"urls"]];
    coverphoto.links = [Links fromDictionary:[dic objectOrNilForKey:@"links"]];
    
    NSMutableArray *parsedCategories = [NSMutableArray array];
    NSObject *receivedCategories = [dic objectOrNilForKey:@"categories"];
    
    if ([receivedCategories isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *item in (NSArray *)receivedCategories)
        {
            [parsedCategories addObject: [Category fromDictionary:item]];
        }
    }
    
    coverphoto.categories = [NSArray arrayWithArray:parsedCategories];;
    
    return coverphoto;
}

@end
