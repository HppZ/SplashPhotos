//
//  SPPhotoBrowserDelegate.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/24.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPhotoBrowser.h"

typedef void (^ ActionButtonCallback)(NSInteger index);

@interface SPPhotoBrowserDelegate : NSObject<MWPhotoBrowserDelegate>

- (id)initWithItems:(UINavigationController *)navigationController
actionButtonCallback: (ActionButtonCallback) actionButtonCallback;

-(void)showPhotoBroswerWithArray: (NSArray*)items startIndex: (NSInteger) index;


@end
