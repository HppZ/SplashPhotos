//
//  ToastService.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/22.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToastService : NSObject

+(void)showToastWithStatus:(NSString*)text;
+(void)showToastWithStatus:(NSString*)text dissmissAfter:(NSTimeInterval)time;

@end
