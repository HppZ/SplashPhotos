//
//  CollectionViewCell.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/3.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "PhotosCollectionViewCell.h"
#import "UIColor+HPZColor.h"

@interface PhotosCollectionViewCell ()

@end

@implementation PhotosCollectionViewCell

#pragma mark init
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor randomColor];
}

@end
