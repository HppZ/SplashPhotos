//
//  CategoryController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CategoryController.h"
#import "Category.h"
#import "UnsplashAPIService.h"
#import "GetCategoriesParam.h"
#import "GetCategoryPhotosParam.h"

@interface CategoryController()
{
    UnsplashAPIService * _apiService;
}
@end

@implementation CategoryController

-(id)init
{
    self  = [super init];
    if(self)
    {
        _apiService = [UnsplashAPIService sharedInstance];
    }
    return self;
}

-(void)loadCategories: (DataRequestResultCompletionBlock) complete
{
    [_apiService GetCategories:^(NSArray * _Nullable data, id  _Nullable response, NSError * _Nullable error)
     {
         complete(data, error);
    }];
}

-(void)loadCategoryPhotos:(Category*)category page: (NSInteger)page complete: (DataRequestResultCompletionBlock) complete
{
    GetCategoryPhotosParam* param = [[GetCategoryPhotosParam alloc]initWithId:category.id page:page perPage:28];
    
    [_apiService GetCategoryPhotos:param
                   completionBlock:^(NSArray * _Nullable data, id  _Nullable response, NSError * _Nullable error)
     {
         complete(data, error);
     }];
}

@end
