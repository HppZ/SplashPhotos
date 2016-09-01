//
//  CollectionManager.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionManager : NSObject

+ (id)sharedCollectionManager;

-(void)loadMoreCollectionsWithCallback:(void(^) (NSString* errormsg)) success;
-(NSMutableArray*)getCollections;
-(int)getCurrentPageNum;

@end
