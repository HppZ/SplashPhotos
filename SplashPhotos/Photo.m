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
    
    photo.id = [dic objectOrNilForKey: @"id"];
    photo.likes = [dic objectOrNilForKey: @"likes"];
    photo.width = [dic objectOrNilForKey: @"width"];
    photo.height = [dic objectOrNilForKey: @"height"];
    photo.color = [dic objectOrNilForKey: @"color"];
    photo.liked_by_user = [dic objectOrNilForKey: @"liked_by_user"];
    photo.created_at = [dic objectOrNilForKey: @"created_at"];
    photo.user = [User fromDictionary:[dic objectOrNilForKey: @"user"]];
    photo.urls = [Urls fromDictionary:[dic objectOrNilForKey: @"urls"]];
    photo.links = [Links fromDictionary:[dic objectOrNilForKey: @"links"]];
    
    return photo;
}
@end
