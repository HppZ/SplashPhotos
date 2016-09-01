//
//  CategoryManager.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CategoryManager.h"
#import "UnsplashAPIService.h"
#import "Category.h"
#import "CategoryRequest.h"

@interface CategoryManager ()
{
    UnsplashAPIService * _unsplashAPIService;
    NSMutableArray<Category *>* _categories;
    NSMutableArray<CategoryRequest*>* _categoryRequests;
}
@end

@implementation CategoryManager

#pragma mark init
+ (id)sharedCategoryManager
{
    static CategoryManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init
{
    self  = [super init];
    if(self)
    {
        _unsplashAPIService = [[UnsplashAPIService alloc] init];
        
        _categories = [[NSMutableArray<Category *>  alloc] init];
        _categoryRequests = [[NSMutableArray<CategoryRequest *> alloc] init];
    }
    
    return self;
}

#pragma mark public
-(void)loadCategories:(void(^) (NSString* errormsg)) success
{
    [_unsplashAPIService GetCategoriesWithsuccessCallback:^(NSArray<Category*> *categories)
     {
         [_categories removeAllObjects];
          [_categoryRequests removeAllObjects];
          
         for(Category* obj in categories)
         {
             [_categories addObject: obj];
             CategoryRequest * request= [[CategoryRequest alloc]initWithId: [obj.id intValue]];
             [_categoryRequests addObject:request];
         }
         
         success(nil);
     }
                                           errorCallback:^(NSString *errorMsg)
     {
         success( errorMsg);
     }];
}

-(void)loadPhotosInCategoryWithID:(int)id success:(void(^) (NSString* errormsg)) success
{
    if([self getIsLoadingWithCategoryID:id])
    {
        return;
    }
    
    [self disableLoadingWithID:id flag: true];
    
    __weak CategoryManager *weakSelf = self;
    int page =[self getCategoryRequestWithID:id].page;
    
    [_unsplashAPIService GetPhotosInCategoryWithID:id page:page
                                  successCallback:^(NSArray *photos)
     {
         NSMutableArray *array = [self getCategoryRequestWithID:id].result;
         for(NSObject* obj in photos)
         {
             [array addObject: obj];
         }

         [weakSelf increasePageNumWithID:id];
         [weakSelf disableLoadingWithID:id flag:false];
         success(nil);
     }
                               errorCallback:^(NSString *errorMsg)
     {
         
         [weakSelf disableLoadingWithID:id flag:false];
         success( errorMsg);
     }];
}

-(void)loadPhotosInCategoryWithName:(NSString*)name success:(void(^) (NSString* errormsg)) success
{
    int  id = [self getCategoryIDWithName: name];
    [self loadPhotosInCategoryWithID:id success:success];
}

-(NSArray*)getCategories
{
    return _categories;
}

-(NSMutableArray*)getPhotosInCategoryWithName:(NSString*)name
{
    int id = [self getCategoryIDWithName: name];
    return [self getPhotosInCategoryWithID: id];
}


-(NSMutableArray*)getPhotosInCategoryWithID:(int)id
{
    return [self getCategoryRequestWithID:id].result;
}

-(int)getCategoryPageWithName:(NSString*) categoryName
{
    int id = [self getCategoryIDWithName: categoryName];
    return [self getPageNumWithID:id];
}

-(int)getPageNumWithID: (int)id
{
    return [self getCategoryRequestWithID:id].page - 1;
}

#pragma mark private
-(CategoryRequest*)getCategoryRequestWithName:(NSString*)name
{
    int id = [self getCategoryIDWithName:name];
    return [self getCategoryRequestWithID: id];
}

-(CategoryRequest*)getCategoryRequestWithID:(int)id
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(id == %i)", id];
    NSArray *filtered = [_categoryRequests filteredArrayUsingPredicate:pred];
    return [filtered lastObject];
}

-(int)getCategoryIDWithName:(NSString*)name
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(title == %@)", name];
    NSArray *filtered = [_categories filteredArrayUsingPredicate:pred];
    Category * cy  = [filtered lastObject];
    return [cy.id intValue];
}

-(Category*)getCategoryWithID:(int)id
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(id == %i)", id];
    NSArray *filtered = [_categories filteredArrayUsingPredicate:pred];
    Category * cy = [filtered lastObject];
    return cy;
}

-(void)increasePageNumWithID:(int)id
{
    ++[self getCategoryRequestWithID:id].page;
}

-(BOOL)getIsLoadingWithCategoryID:(int)id
{
    return [self getCategoryRequestWithID:id].isloading;
}

-(void)disableLoadingWithID:(int) id flag:(bool) flag
{
    [self getCategoryRequestWithID:id].isloading= flag;
}
@end
