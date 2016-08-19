//
//  CategoryManager.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryManager : NSObject

+ (id)sharedCategoryManager;

-(void)loadCategories:(void(^) (NSString* errormsg)) success;
-(void)loadPhotosInCategoryWithID:(int)id success:(void(^) (NSString* errormsg)) success;
-(void)loadPhotosInCategoryWithName:(NSString*)name success:(void(^) (NSString* errormsg)) success;

-(NSArray*)getCategories;

@end
