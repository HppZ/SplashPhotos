//
//  DownloadTableViewCell.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "DownloadTableViewCell.h"
#import "UIColor+HPZColor.h"
#import "DownloadPhoto.h"

@interface DownloadTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UILabel *numprogress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation DownloadTableViewCell

#pragma setup
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self showRestartButton: false];
}

#pragma mark 设置属性
-(void)cellProgress: (float) value
{
    _progressView.progress = value;
    
    int val = value *100;
    _numprogress.text = [[NSString stringWithFormat:@"%d", val] stringByAppendingString:@"%"];
}

-(void)cellThumb: (NSString*)url
{
    [_thumb sd_setImageWithURL:[NSURL URLWithString: url] placeholderImage: nil];
}

-(void)cellDownloadState:(DownloadState ) state
{
    BOOL flag= false;
    switch (state)
    {
        case DownloadFailed:
            flag  =true;
            break;
            
        default:
            break;
    }
    
    [self showRestartButton: flag];
}

-(void)showRestartButton: (BOOL)flag
{
    [_restartButton setAlpha: flag ? 1.0 : 0.0];
}

#pragma mark click

- (IBAction)restartClicked:(id)sender
{
    [self.delegate didClickOnCell:self sender:nil];
}

#pragma mark 通知
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"proress"])
    {
        float val = [[change objectForKey:@"new"] floatValue];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self cellProgress:val];
                       });
        
    }
    else if([keyPath isEqualToString:@"downloadState"])
    {
        DownloadState val = (DownloadState)([[change valueForKey:@"new"] intValue]);
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self cellDownloadState:val];
                       });
    }
}

@end
