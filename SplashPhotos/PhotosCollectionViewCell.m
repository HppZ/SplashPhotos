//
//  CollectionViewCell.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/3.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "PhotosCollectionViewCell.h"
#import "UIColor+HPZColor.h"

@interface PhotosCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@end

@implementation PhotosCollectionViewCell
#pragma mark init
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor randomColor];
}

#pragma mark 设置属性
-(void)cellThumb: (NSString*)url
{
    [_image sd_setImageWithURL:[NSURL URLWithString: url] placeholderImage: nil];
}
@end
