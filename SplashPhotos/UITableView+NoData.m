//
//  UITableView+NoData.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/10.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UITableView+NoData.h"

@implementation UITableView (NoData)

- (void) tableViewDisplayWitMsg:(NSString *) message rowCount:(NSUInteger) rowCount
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
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else
    {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

@end
