//
//  CategoryCollectionViewCell.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CategoryCollectionViewCell.h"
#import "UIColor+HPZColor.h"

@interface CategoryCollectionViewCell()

@end

@implementation CategoryCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor randomColor];
}

@end
