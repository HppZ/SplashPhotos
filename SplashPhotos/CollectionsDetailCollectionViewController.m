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
    NSMutableArray * _collectionPhotos;
    int _page;
}

@property ArrayDataSource* arrayDataSource;
@end

@implementation CollectionsDetailCollectionViewController

static NSString * const reuseIdentifier = @"collectionsDetailCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self triggerPullToRefresh];
}

-(void)setup
{
    // init
    _photoService = [[PhotoService alloc] init];
    _collectionPhotos = [[NSMutableArray alloc]init];
    _page = 1;
    
    // configure cell
    CellConfigureBlock configureCell = ^(CollectionsDetailCollectionViewCell *cell, Photo *photo)
    {
        [cell configureForPhoto: photo delegate: self];
    };
    
    // data source
    self.arrayDataSource = [[ArrayDataSource alloc] initWithItems:_collectionPhotos
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
}

#pragma mark - data
-(void)loadData
{
    __weak CollectionsDetailCollectionViewController * weakSelf = self;
    
    [_photoService loadCollectionDetailWithID: [self.collection.id intValue] page: _page
                              successCallback:^(NSArray *result)
    {
        _page++;
        [weakSelf stopRefresh];
        for (Photo* photo in result)
        {
            [_collectionPhotos addObject:photo];
        }
        
        [self insertNewItems];
    }
                                errorCallback:^(NSString *errorMsg)
    {
        [weakSelf topBarMsg: errorMsg];
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
    self.navigationItem.title = [NSString stringWithFormat:@"%@" ,self.collection.title];
}

-(void)topBarMsg:(NSString*)text
{
    [ToastService showToastWithStatus:text];
}

#pragma mark dealloc
-(void)dealloc
{

}

@end
