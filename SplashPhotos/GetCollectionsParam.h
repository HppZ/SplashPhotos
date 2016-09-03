//
//  GetCollectionsParam.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCollectionsParam : NSObject

@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger perPage;

-(id)initWithPage:(NSInteger) page perPage: (NSInteger) perPage;

@end
