//
//  CollectionsTableViewCell+ConfigureCell.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsTableViewCell.h"

@class Collection;

@interface CollectionsTableViewCell (ConfigureCell)

- (void)configureForPhoto:(Collection *)collection delegate: (id<CollectionsTableViewCellDelegate>) delegate;

@end
