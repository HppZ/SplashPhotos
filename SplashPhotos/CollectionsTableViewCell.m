//
//  CollectionsTableViewCell.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsTableViewCell.h"

@interface CollectionsTableViewCell()

@end

@implementation CollectionsTableViewCell

#pragma mark init
-(void)awakeFromNib
{
    [self.userIconElement addTapGestureWithTarget:self selector:@selector(userTapped:)];
    [self.usernameElement addTapGestureWithTarget:self selector:@selector(userTapped:)];
    [self addTapGestureWithTarget: self selector:@selector(selfTapped:)];
}

#pragma mark tapped
-(BOOL)selfTapped:(UITapGestureRecognizer *)recognizer
{
    [self.delegate collectionClicked: self sender:nil];
    return YES;
}

-(BOOL)userTapped:(UITapGestureRecognizer *)recognizer
{
    [self.delegate userClicked: self sender:nil];
    return YES;
}

@end
