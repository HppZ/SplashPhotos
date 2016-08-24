//
//  PhotosCollectionViewCell+ConfigureCell.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/24.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "PhotosCollectionViewCell.h"

@class Photo;

@interface PhotosCollectionViewCell (ConfigureCell)

- (void)configureForPhoto:(Photo *)photo;

@end
