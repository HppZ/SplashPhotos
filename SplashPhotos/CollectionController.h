//
//  CollectionController.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/2.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Photo;
@class Collection;

@interface CollectionController : NSObject

-(void)loadCollections:(NSInteger) page complete: (DataRequestResultCompletionBlock) complete;
-(void)loadCollectionPhotos:(Collection *) collection page: (NSInteger)page complete: (DataRequestResultCompletionBlock) complete;

-(void)requestDownload: (Photo*) photo;

@end
