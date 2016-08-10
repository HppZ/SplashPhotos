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
}

#pragma mark 设置属性

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setProgress: (float) value
{
    _progressView.progress = value;
    int val = value *100;
    _numprogress.text = [[NSString stringWithFormat:@"%d", val] stringByAppendingString:@"%"];
}

-(void)setThumbUrl: (NSString*)url
{
    [_thumb sd_setImageWithURL:[NSURL URLWithString: url] placeholderImage: nil];
}

#pragma mark 通知
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"proress"])
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            float val = [[change objectForKey:@"new"] floatValue];
            [self setProgress:val];
        });
    }
}

@end
