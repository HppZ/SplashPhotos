//
//  MainViewCollectionViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/3.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotosCollectionViewCell.h"
#import "Photo.h"
#import "Urls.h"
#import "PhotoService.h"
#import "ToastService.h"
#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import "UICollectionView+NoData.h"
#import "ArrayDataSource.h"
#import "PhotosCollectionViewCell.h"
#import "PhotosCollectionViewCell+ConfigureCell.h"
#import "SPPhotoBrowserDelegate.h"

@interface PhotoCollectionViewController ()
{
    PhotoService * _photoService;
    SPPhotoBrowserDelegate * _photoBrowserDelegate;
}

@property ArrayDataSource *photosArrayDataSource;

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
    // photo browser configure
    ActionButtonCallback actioncallback = ^(NSInteger index)
    {
        [self savePhotoAt: index];
    };

    _photoBrowserDelegate = [[SPPhotoBrowserDelegate alloc]initWithItems:self.navigationController
                                                    actionButtonCallback:actioncallback actionButton:true];
    
    _photoService = [[PhotoService alloc] init];
    
    // get photos data
    NSMutableArray<Photo *>* photos  = [_photoService getDataSource];
    
    // configure cell
    CellConfigureBlock configureCell = ^(PhotosCollectionViewCell *cell, Photo *photo)
    {
        [cell configureForPhoto:photo];
    };
    
    // data source
    self.photosArrayDataSource = [[ArrayDataSource alloc] initWithItems:photos
                                                         cellIdentifier:reuseIdentifier
                                                     configureCellBlock:configureCell
                                                              noDataTip:@"pull to refresh"];
    self.photosArrayDataSource.isReverse = true;
    self.collectionView.dataSource = self.photosArrayDataSource;

    // pull to refresh
    __weak typeof(self) weakSelf = self;
    [self.collectionView addPullToRefreshActionHandler:
     ^{
         typeof(self) strongSelf = weakSelf;
         [strongSelf loadData];
     }
                                 ProgressImagesGifName:@"spinner_dropbox@2x.gif"
                                  LoadingImagesGifName:@"run@2x.gif"
                               ProgressScrollThreshold:60
                                 LoadingImageFrameRate:30];
    
    // photo souce change notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:[PhotoService photoSourceChangedNotification]
                                               object:nil];
    
    
    // get categories now
    [_photoService requestCategoriesWithCallback:^(NSString *errormsg)
     {
         if(errormsg)
         {
             NSLog(@"%@", [@"load more failed " stringByAppendingString:errormsg]);
             [weakSelf topBarMsg: errormsg];
         }
     }];
}

#pragma mark notification
- (void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString: [PhotoService photoSourceChangedNotification]])
    {
        [self insertNewItems];
    }
}

#pragma mark data
-(void)loadData
{
    __weak PhotoCollectionViewController * weakSelf = self;
    
    [_photoService loadMoreDataWithCallback:^( NSString* errormsg)
     {
         [weakSelf stopRefresh];
         if(errormsg)
         {
             NSLog(@"%@", [@"load more failed " stringByAppendingString:errormsg]);
             [weakSelf topBarMsg: errormsg];
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
    NSInteger max = ((NSArray*)[self.photosArrayDataSource allItems]).count - count;
    
    NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
    for (NSInteger i = 0; i <  max ; i++)
    {
        [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow: i inSection:0]];
    }
    [self.collectionView insertItemsAtIndexPaths: arrayWithIndexPaths];
}

#pragma mark <UICollectionViewDelegate>, open photo browser
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* items = [self.photosArrayDataSource allItems];
    NSMutableArray* photos = [NSMutableArray new];
    NSUInteger first = items.count;
    for (NSUInteger i = first; i >= 1; i--)
    {
        Photo* p = [items objectAtIndex: i-1];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: [[p urls] regular]]]];
    }
    
    [_photoBrowserDelegate showPhotoBroswerWithArray:photos startIndex:indexPath.item];
}

#pragma mark UI helper
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
    //int pagenum = [_photoService getCurrentPageNum];
    self.navigationItem.title = [NSString  stringWithFormat:@"NEW"];
}

-(void)topBarMsg:(NSString*)text
{
    [ToastService showToastWithStatus:text];
}

#pragma mark download
-(void)savePhotoAt: (NSInteger)index
{
    [self topBarMsg: @"Downloading..."];
    
    Photo * photo = [self.photosArrayDataSource itemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [_photoService requestDownload: photo];
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
