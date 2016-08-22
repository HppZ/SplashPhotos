//
//  PhotosController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/4.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "PhotoManager.h"
#import "UnsplashAPIService.h"

@interface PhotoManager ()
{
    int _num;
    bool _loading;
    
    UnsplashAPIService * _unsplashAPIService;
    NSMutableArray<Photo *>* _photos;
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
        _photos = [[NSMutableArray<Photo*>  alloc] init];
        _unsplashAPIService = [[UnsplashAPIService alloc] init];
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
    
    [self disableLoading: true];
    
    __weak id weakSelf = self;
    [_unsplashAPIService GetPhotosWithPageNum:_num
                             successCallback:^(NSArray* photos)
     {
         for(id obj in photos)
         {
             [_photos addObject: obj];
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

-(NSMutableArray*)getDataSource
{
    return _photos;
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
