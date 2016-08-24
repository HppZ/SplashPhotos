//
//  DownloadTableViewCell+ConfigureCell.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/24.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "DownloadTableViewCell.h"

@interface DownloadTableViewCell (ConfigureCell)

- (void)configureForPhoto:(DownloadPhoto *)photo delegate: (id<DownloadTableViewCellDelegate>) delegate;

@end
