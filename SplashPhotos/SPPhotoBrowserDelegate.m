//
//  SPPhotoBrowserDelegate.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/24.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "SPPhotoBrowserDelegate.h"

@interface SPPhotoBrowserDelegate()

@property (nonatomic) UINavigationController* navigationController;
@property (nonatomic, copy) NSArray<MWPhoto*>* items;
@property (nonatomic, copy) ActionButtonCallback actionButtonCallback;

@end

@implementation SPPhotoBrowserDelegate

- (id)initWithItems:(UINavigationController *)navigationController
actionButtonCallback: (ActionButtonCallback) actionButtonCallback
{
    self = [super init];
    if (self)
    {
        _navigationController = navigationController;
        _actionButtonCallback = [actionButtonCallback copy];
    }
    return self;
}

-(void)showPhotoBroswerWithArray: (NSArray*)items startIndex: (NSInteger) index
{
    self.items = items;
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = YES; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex: index];
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
}


#pragma mark MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.items.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.items.count) {
        return [self.items objectAtIndex:index];
    }
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index
{
    self.actionButtonCallback(index);
}


@end
