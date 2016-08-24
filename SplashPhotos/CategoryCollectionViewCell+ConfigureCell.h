//
//  CategoryCollectionViewCell+ConfigureCell.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/24.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import "Photo.h"

@interface CategoryCollectionViewCell (ConfigureCell)

- (void)configureForPhoto:(Photo *)photo;

@end
