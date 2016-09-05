//
//  CategoryController.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Category;
@class Photo;

@interface CategoryController : NSObject

-(void)loadCategories: (DataRequestResultCompletionBlock) complete;
-(void)loadCategoryPhotos:(Category*)category page: (NSInteger)page complete: (DataRequestResultCompletionBlock) complete;

@end
