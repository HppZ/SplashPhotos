//
//  PhotosController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "PhotoManager.h"
#import "UnsplashAPIHelper.h"

@interface PhotoManager ()
{
    int _num;
    bool _loading;
    
    UnsplashAPIHelper * _unsplashAPIHelper;
    NSMutableArray<Photo *>* _collectionViewData;
}
@end

@implementation PhotoManager

#pragma mark 单例
+ (id)sharedPhotoManager
{
    static PhotoManager *sharedInstance = nil;
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
        _collectionViewData = [[NSMutableArray<Photo*>  alloc] init];
        _unsplashAPIHelper = [[UnsplashAPIHelper alloc] init];
        _num = 1;
    }
    
    return self;
}

#pragma mark public
-(void)loadMoreDataWithCallback:(void(^) (NSString* errormsg)) success
{
    if(_loading)
    {
        return;
    }
    
    [self disableLoading:true];
    
    __weak id weakSelf = self;
    [_unsplashAPIHelper GetPhotosWithPageNum:_num
                             successCallback:^(NSArray* photos)
     {
         for(id obj in photos)
         {
             [_collectionViewData addObject: obj];
         }
         
         [weakSelf increasePageNum];
         success(nil);
         [self disableLoading:false];
     }
                               errorCallback:^(NSString *errorMsg)
     {
         success( errorMsg);
         [self disableLoading:false];
     }];
}

-(NSMutableArray*)getDataSource
{
    return _collectionViewData;
}

-(int)getCurrentPageNum
{
    return _num-1;
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
