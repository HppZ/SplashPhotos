//
//  Photo.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "Photo.h"
#import "Urls.h"

@implementation Photo

+(Photo*) fromDictionary: (NSDictionary*) dic
{
    Photo * photo  = [[Photo alloc] init];
    
    photo.id = [dic objectForKey: @"id"];
    photo.likes = [dic objectForKey: @"likes"];
    photo.width = [dic objectForKey: @"width"];
    photo.height = [dic objectForKey: @"height"];
    photo.color = [dic objectForKey: @"color"];
    photo.liked_by_user = [dic objectForKey: @"liked_by_user"];
    photo.created_at = [dic objectForKey: @"created_at"];
    photo.user = [User fromDictionary:[dic objectForKey: @"user"]];
    photo.urls = [Urls fromDictionary:[dic objectForKey: @"urls"]];
    photo.links = [Links fromDictionary:[dic objectForKey: @"links"]];
    
    return photo;
}
@end
