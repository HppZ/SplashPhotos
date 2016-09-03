//
//  CategoryPhotosCollectionViewController.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@class Category;

@interface CategoryPhotosCollectionViewController : UICollectionViewController

@property (nonatomic) Category* category;

@end
