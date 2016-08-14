//
//  DownloadTableViewCell.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadPhoto.h"

@class DownloadTableViewCell;

@protocol CellDelegate <NSObject>
- (void)didClickOnCell:(DownloadTableViewCell*)cell sender:(id)sender;
@end

@interface DownloadTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) id<CellDelegate> delegate;

-(void)cellThumb: (NSString*)url;
-(void)cellProgress: (float) value;
-(void)cellDownloadState:(DownloadState) state;

@end
