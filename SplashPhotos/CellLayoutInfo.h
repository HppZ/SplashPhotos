//
//  CellLayoutInfo.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/1.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellLayoutInfo : NSObject

@property (nonatomic) NSIndexPath * indexPath;
@property (nonatomic) CGRect frame;


-(id)initWithIndexPath: (NSIndexPath*) indexPath frame: (CGRect) frame;

@end
