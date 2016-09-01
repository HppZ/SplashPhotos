//
//  Collection
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "Collection.h"
#import "CoverPhoto.h"
#import "User.h"
#import "Links.h"

@implementation Collection

+(Collection*) fromDictionary: (NSDictionary*) dic
{
    Collection *collection = [[Collection alloc]init];
    
    collection.id =  [dic objectOrNilForKey:@"id"];
    collection.title =  [dic objectOrNilForKey:@"title"];
    collection.description_ =  [dic objectOrNilForKey:@"description"];
    collection.published_at =  [dic objectOrNilForKey:@"published_at"];
    collection.curated =  [dic objectOrNilForKey:@"curated"];
    collection.total_photos =  [[dic objectOrNilForKey:@"total_photos"] stringValue];
    collection.private_ =  [dic objectOrNilForKey:@"private"];
    collection.share_key =  [dic objectOrNilForKey:@"share_key"];
    collection.cover_photo =  [CoverPhoto fromDictionary: [dic objectOrNilForKey:@"cover_photo"]];
    collection.user =  [User fromDictionary: [dic objectOrNilForKey:@"user"]];
    collection.links =  [Links fromDictionary: [dic objectOrNilForKey:@"links"]];
    
    return collection;
}

@end
