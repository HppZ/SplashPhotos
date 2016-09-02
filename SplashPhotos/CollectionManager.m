//
//  CollectionManager.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionManager.h"
#import "UnsplashAPIService.h"

@interface CollectionManager()
{
    int _num;
    bool _loading;
    
    UnsplashAPIService * _unsplashAPIService;
    NSMutableArray<Photo *>* _collections;
}
@end

@implementation CollectionManager

#pragma mark 单例
+ (id)sharedCollectionManager
{
    static CollectionManager *sharedInstance = nil;
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
        _collections = [[NSMutableArray<Photo*>  alloc] init];
        _unsplashAPIService = [[UnsplashAPIService alloc] init];
        _num = 1;
    }
    
    return self;
}

#pragma mark public
-(void)loadMoreCollectionsWithCallback:(void(^) (NSString* errormsg)) success
{
    if(_loading)
    {
        return;
    }
    
    [self disableLoading: true];
    
    __weak id weakSelf = self;
    [_unsplashAPIService GetCollectionsWithPage: _num
                              successCallback:^(NSArray* collections)
     {
         for(id obj in collections)
         {
             [_collections addObject: obj];
         }
         
         [weakSelf increasePageNum];
         [weakSelf disableLoading:false];
         success(nil);
         
     }
                                errorCallback:^(NSString *errorMsg)
     {
         [weakSelf disableLoading:false];
         success( errorMsg);
     }];
}

-(NSMutableArray*)getCollections
{
    return _collections;
}

-(int)getCurrentPageNum
{
    return _num-1;
}


#pragma mark collections detail
-(void)loadCollectionDetailWithID:(int)id page: (int)page successCallback:(void (^)(NSArray * result)) resultCallback errorCallback:(void (^)(NSString *errorMsg)) errorCallback
{
    [_unsplashAPIService GetPhotosInCollectionWith:id page:page successCallback:resultCallback errorCallback:errorCallback];
}

#pragma mark private
-(void)increasePageNum
{
    ++_num;
}

-(void)disableLoading:(bool) flag
{
    _loading = flag;
}

@end
