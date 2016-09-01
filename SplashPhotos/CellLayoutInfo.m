//
//  CellLayoutInfo.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/9/1.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CellLayoutInfo.h"

@implementation CellLayoutInfo

-(id)init
{
    return nil;
}

-(id)initWithIndexPath: (NSIndexPath*) indexPath frame: (CGRect) frame
{
    self = [super init];
    if(self)
    {
        _indexPath = indexPath;
        _frame = frame;
    }
    
    return self;
}

@end
