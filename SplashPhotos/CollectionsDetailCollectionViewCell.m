//
//  CollectionsDetailCollectionViewCell.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/31.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsDetailCollectionViewCell.h"
#import "UIColor+HPZColor.h"

@interface CollectionsDetailCollectionViewCell ()

@end

@implementation CollectionsDetailCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor randomColor];
}


@end
