//
//  CollectionController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionController.h"
#import "UnsplashAPIService.h"
#import "GetCollectionsParam.h"
#import "GetCollectionPhotosParam.h"
#import "Collection.h"
#import "DownloadManager.h"

@interface CollectionController()
{
    UnsplashAPIService * _apiService;
}
@end

@implementation CollectionController

-(id)init
{
    self  = [super init];
    if(self)
    {
        _apiService = [UnsplashAPIService sharedInstance];
    }
    return self;
}


#pragma mark public
-(void)loadCollections:(NSInteger) page complete: (DataRequestResultCompletionBlock) complete
{
    GetCollectionsParam * param = [[GetCollectionsParam alloc]initWithPage:page perPage:10];
    
    [_apiService    GetCollections:param
                   completionBlock:^(NSArray * _Nullable data, id  _Nullable response, NSError * _Nullable error)
    {
        complete(data, error);
    }];
}



#pragma mark collections detail
-(void)loadCollectionPhotos:(Collection *) collection page: (NSInteger)page complete: (DataRequestResultCompletionBlock) complete
{
    GetCollectionPhotosParam * param = [[GetCollectionPhotosParam alloc] initWithId: collection.id page:page perPage:30];
    [_apiService GetCollectionPhotos:param
                     completionBlock:^(NSArray * _Nullable data, id  _Nullable response, NSError * _Nullable error)
    {
        complete(data, error);
    }];
}


-(void)requestDownload: (Photo*) photo
{
    [DownloadManager.sharedInstance requestDownload:photo];
}

@end
