//
//  UITableView+NoData.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/10.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (NoData)
- (void) tableViewDisplayWitMsg:(NSString *) message rowCount:(NSUInteger) rowCount;
@end
