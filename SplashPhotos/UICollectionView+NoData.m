//
//  UICollectionView+NoData.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/21.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UICollectionView+NoData.h"

@implementation UICollectionView (NoData)

- (void) collectionViewDisplayWitMsg:(NSString *) message rowCount:(NSUInteger) rowCount
{
    if(rowCount <= 0)
    {
        UILabel *messageLabel = [UILabel new];
        
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
    }
    else
    {
        self.backgroundView = nil;
    }
}

@end
