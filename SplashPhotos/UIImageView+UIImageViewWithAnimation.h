//
//  UIImageView+UIImageViewWithAnimation.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/1.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (UIImageViewWithAnimation)

-(void)animateImageWithURL: (NSURL *)url placeholderImage:(UIImage *)placeholder;

@end
