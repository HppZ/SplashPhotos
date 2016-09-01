//
//  DownloadTableViewCell+ConfigureCell.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/24.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "DownloadTableViewCell+ConfigureCell.h"
#import "DownloadPhoto.h"

@implementation DownloadTableViewCell (ConfigureCell)

- (void)configureForPhoto:(DownloadPhoto *)photo delegate: (id<DownloadTableViewCellDelegate>) delegate
{
    [self cellThumb:[photo thumb]];
    [self cellProgress: [photo proress]];
    [self cellDownloadState: photo.downloadState];
    self.delegate = delegate;
    
    [photo addObserver:self
            forKeyPath:@"proress"
               options:NSKeyValueObservingOptionNew
               context:NULL];
    [photo addObserver:self
            forKeyPath:@"downloadState"
               options:NSKeyValueObservingOptionNew
               context:NULL];
}


@end
