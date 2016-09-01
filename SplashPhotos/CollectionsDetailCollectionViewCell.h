//
//  CollectionsDetailCollectionViewCell.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/31.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CollectionDetailCellDelegate <NSObject>

@end


@interface CollectionsDetailCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id<CollectionDetailCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *photoElement;

@end
