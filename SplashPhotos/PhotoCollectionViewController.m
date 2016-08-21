//
//  MainViewCollectionViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/3.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "PhotoCollectionViewController.h"
#import "PhotosCollectionViewCell.h"
#import "Photo.h"
#import "Urls.h"
#import "PhotoService.h"
#import "JDStatusBarNotification.h"
#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"

@interface PhotoCollectionViewController ()
{
    NSMutableArray<Photo *>* _collectionViewData;
    PhotoService * _photoService;
    NSMutableArray *_photosForBrowsing;
}
@end

@implementation PhotoCollectionViewController

static NSString * const reuseIdentifier = @"mainCell";

#pragma mark view setup
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self triggerPullToRefresh];
}

-(void)viewWillLayoutSubviews
{
    float w = (self.collectionView.frame.size.width - 2.5 ) / 3;
    ((UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout).itemSize = CGSizeMake(w,w);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup
{
    // pull to refresh
    __weak typeof(self) weakSelf =self;
    [self.collectionView addPullToRefreshActionHandler:
     ^{
         typeof(self) strongSelf = weakSelf;
         [strongSelf loadData];
     }
                                 ProgressImagesGifName:@"spinner_dropbox@2x.gif"
                                  LoadingImagesGifName:@"run@2x.gif"
                               ProgressScrollThreshold:60
                                 LoadingImageFrameRate:30];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:[PhotoService photoSourceChangedNotification]
                                               object:nil];
    
    _photoService = [[PhotoService alloc] init];
    _collectionViewData  = [_photoService getDataSource];
    _photosForBrowsing = [[NSMutableArray alloc] init];
    
    // 提前获取侧栏分类
    [_photoService requestCategoriesWithCallback:^(NSString *errormsg)
     {
         if(errormsg)
         {
             NSLog(@"%@", [@"load more failed " stringByAppendingString:errormsg]);
             [weakSelf showPop: errormsg];
         }
     }];
}

#pragma mark 通知
- (void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString: [PhotoService photoSourceChangedNotification]])
    {
        [self insertNewItems];
    }
}

#pragma mark - data
-(void)loadData
{
    __weak PhotoCollectionViewController * weakSelf = self;
    
    [_photoService loadMoreDataWithCallback:^( NSString* errormsg)
     {
         [weakSelf stopRefresh];
         if(errormsg)
         {
             NSLog(@"%@", [@"load more failed " stringByAppendingString:errormsg]);
             [weakSelf showPop: errormsg];
         }
         else
         {
             [weakSelf navBarTitle];
         }
     }];
}

-(void)insertNewItems
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    NSInteger max = _collectionViewData.count;
    
    NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
    for (NSInteger i = 0; i <  max - count; i++)
    {
        [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow: i inSection:0]];
    }
    [self.collectionView insertItemsAtIndexPaths: arrayWithIndexPaths];
}

#pragma mark UI 设置
-(void)stopRefresh
{
    [self.collectionView stopPullToRefreshAnimation];
}

-(void)triggerPullToRefresh
{
    [self.collectionView triggerPullToRefresh];
}

-(void)navBarTitle
{
    int pagenum = [_photoService getCurrentPageNum];
    self.navigationItem.title = [NSString  stringWithFormat:@"New-%d" ,pagenum];
}

-(void)showPop:(NSString*)text
{
    [JDStatusBarNotification showWithStatus:text dismissAfter: 1];
}

#pragma mark MWPhotoBrowser
-(void)cellClicked: (NSIndexPath*) indexPath
{
    [_photosForBrowsing removeAllObjects];
    
    int first = _collectionViewData.count - 1;
    for (int i = first; i >= 0; i--)
    {
        Photo* p = [_collectionViewData objectAtIndex:i];
        [_photosForBrowsing addObject:[MWPhoto photoWithURL:[NSURL URLWithString: [[p urls] regular]]]];
    }
    
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
    [browser setCurrentPhotoIndex: indexPath.item];
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _photosForBrowsing.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _photosForBrowsing.count) {
        return [_photosForBrowsing objectAtIndex:index];
    }
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index
{
    [self showPop: @"Downloading..."];
    
    Photo * photo = [self getItemWithIndexPath: [NSIndexPath indexPathForItem:index inSection:0]];
    [_photoService requestDownload: photo];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionViewData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Photo *photo =  [self getItemWithIndexPath:indexPath];
    [cell cellThumb:[[photo urls] small]];
    
    return cell;
}

#pragma mark 点击图片 <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self cellClicked: indexPath];
}

-(id)getItemWithIndexPath:(NSIndexPath*)indexPath
{
    if(indexPath != nil)
    {
      return  [_collectionViewData objectAtIndex: _collectionViewData.count -1 - indexPath.item];
    }
    return nil;
}

-(void)getIndexWithIndexPath:(NSIndexPath*)indexPath
{
    
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
