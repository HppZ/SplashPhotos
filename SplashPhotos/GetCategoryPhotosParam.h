//
//  GetCategoryPhotosParam.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCategoryPhotosParam : NSObject

@property (nonatomic, copy) NSString* id;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger perPage;


-(id)initWithId: (NSString*) id   page: (NSInteger) page perPage: (NSInteger) perPage;

@end
