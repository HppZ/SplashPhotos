//
//  CollectionsTableViewCell.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionsTableViewCell;

@protocol CollectionsTableViewCellDelegate <NSObject>

-(void)collectionClicked:(CollectionsTableViewCell*)cell sender:(id)sender;
-(void)userClicked:(CollectionsTableViewCell*)cell sender:(id)sender;

@end


@interface CollectionsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberElement;
@property (weak, nonatomic) IBOutlet UILabel *titleElement;
@property (weak, nonatomic) IBOutlet UIImageView *userIconElement;
@property (weak, nonatomic) IBOutlet UILabel *usernameElement;
@property (weak, nonatomic) IBOutlet UIImageView *coverPhotoElement;

@property (weak, nonatomic) id<CollectionsTableViewCellDelegate> delegate;

@end
