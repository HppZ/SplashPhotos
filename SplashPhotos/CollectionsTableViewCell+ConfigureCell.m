//
//  CollectionsTableViewCell+ConfigureCell.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsTableViewCell+ConfigureCell.h"
#import "Collection.h"
#import "Urls.h"
#import "CoverPhoto.h"
#import "User.h"
#import "ProfileImage.h"
#import "UIImageView+UIImageViewWithAnimation.h"

@implementation CollectionsTableViewCell (ConfigureCell)

- (void)configureForPhoto:(Collection *)collection delegate: (id<CollectionsTableViewCellDelegate>) delegate
{
    self.delegate = delegate;
    
    self.numberElement.text = [collection total_photos];
    self.titleElement.text = [collection title];
    self.usernameElement.text = [[collection user] username];

    NSString* url1 = [[[collection user] profile_image] small];
    [self.userIconElement animateImageWithURL:[NSURL URLWithString: url1] placeholderImage: nil];

    NSString* url2 = [[[collection cover_photo] urls] small];
    [self.coverPhotoElement animateImageWithURL:[NSURL URLWithString: url2] placeholderImage: nil];
}

@end
