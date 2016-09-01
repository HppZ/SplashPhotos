//
//  ProfileImage.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "ProfileImage.h"

@implementation ProfileImage

+(ProfileImage*) fromDictionary: (NSDictionary*) dic
{
    ProfileImage * urls = [[ProfileImage alloc] init];
    
    urls.small = [dic objectOrNilForKey: @"small"];
    urls.medium = [dic objectOrNilForKey: @"medium"];
    urls.large = [dic objectOrNilForKey: @"large"];
    
    return urls;
}
@end
