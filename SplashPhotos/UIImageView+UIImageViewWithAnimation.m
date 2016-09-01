//
//  UIImageView+UIImageViewWithAnimation.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/1.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UIImageView+UIImageViewWithAnimation.h"

@implementation UIImageView (UIImageViewWithAnimation)

-(void)animateImageWithURL: (NSURL *)url placeholderImage:(UIImage *)placeholder
{
    self.alpha = 0;
    
    [self sd_setImageWithURL:url placeholderImage: placeholder
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         [UIView animateWithDuration:0.5
                          animations:^
          {
              self.alpha = 1;
          }];
     }];
}

@end
