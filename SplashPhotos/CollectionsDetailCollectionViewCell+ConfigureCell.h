//
//  CollectionsDetailCollectionViewCell+ConfigureCell.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/31.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsDetailCollectionViewCell.h"

@class Photo;

@interface CollectionsDetailCollectionViewCell (ConfigureCell)

- (void)configureForPhoto:(Photo *)collection delegate: (id<CollectionDetailCellDelegate>) delegate;

@end
