//
//  CategoryRequest.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryRequest : NSObject

@property int id;
@property int page;
@property BOOL isloading;
@property NSMutableArray *result;

-(id)initWithId: (int)id;

@end
