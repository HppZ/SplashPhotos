//
//  CollectionsDetailCollectionViewCell+ConfigureCell.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/31.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsDetailCollectionViewCell+ConfigureCell.h"
#import "Photo.h"
#import "Urls.h"
#import "UIImageView+UIImageViewWithAnimation.h"

@implementation CollectionsDetailCollectionViewCell (ConfigureCell)

- (void)configureForPhoto:(Photo *)photo delegate: (id<CollectionDetailCellDelegate>) delegate
{
    [self.photoElement animateImageWithURL:[NSURL URLWithString: photo.urls.small] placeholderImage: nil];
}

@end
