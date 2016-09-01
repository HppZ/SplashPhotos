//
//  CollectionsDetailCollectionViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/31.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsDetailCollectionViewController.h"
#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import "PhotoService.h"
#import "ArrayDataSource.h"
#import "CollectionsDetailCollectionViewCell.h"
#import "ToastService.h"
#import "CollectionsDetailCollectionViewCell+ConfigureCell.h"
#import "Collection.h"

@interface CollectionsDetailCollectionViewController() <CollectionDetailCellDelegate>
{
    PhotoService* _photoService;
}

@property ArrayDataSource* arrayDataSource;
@end

@implementation CollectionsDetailCollectionViewController

static NSString * const reuseIdentifier = @"collectionsDetailCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

-(void)setup
{
    // init
    _photoService = [[PhotoService alloc] init];
    
    // get photos data
    NSMutableArray *collections  = [_photoService getDataSource];
    
    // configure cell
    CellConfigureBlock configureCell = ^(CollectionsDetailCollectionViewCell *cell, Photo *photo)
    {
        [cell configureForPhoto: photo delegate: self];
    };
    
    // data source
    self.arrayDataSource = [[ArrayDataSource alloc] initWithItems:collections
                                                   cellIdentifier:reuseIdentifier
                                               configureCellBlock:configureCell
                                                        noDataTip:@"pull to refresh"];
    self.arrayDataSource.isReverse = true;
    self.collectionView.dataSource = self.arrayDataSource;
    
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
    
    
    // notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:[PhotoService photoSourceChangedNotification]
                                               object:nil];
}

#pragma mark notification
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
    __weak CollectionsDetailCollectionViewController * weakSelf = self;
    
    [_photoService loadMoreDataWithCallback:^(NSString *errormsg)
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

#pragma mark data
-(void)insertNewItems
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    NSInteger max = ((NSArray*)[self.arrayDataSource allItems]).count - count;
    
    NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
    for (NSInteger i = 0; i <  max ; i++)
    {
        [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow: i inSection:0]];
    }
    [self.collectionView insertItemsAtIndexPaths: arrayWithIndexPaths];
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
    self.navigationItem.title = [NSString stringWithFormat:@"%@" ,self.collection.title];
}

-(void)topBarMsg:(NSString*)text
{
    [ToastService showToastWithStatus:text];
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
