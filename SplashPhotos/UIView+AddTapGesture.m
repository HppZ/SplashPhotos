//
//  UIView+AddTapGesture.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/31.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UIView+AddTapGesture.h"

@implementation UIView (AddTapGesture)

-(void)addTapGestureWithTarget: (id) target selector:(SEL) selector
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target
                                                                                action:selector];
    singleTap.numberOfTapsRequired = 1;
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:singleTap];
}

@end
