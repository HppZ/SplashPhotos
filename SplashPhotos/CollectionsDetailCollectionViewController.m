//
//  CollectionsDetailCollectionViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/31.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsDetailCollectionViewController.h"
#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import "SplashControllerAccess.h"
#import "ArrayDataSource.h"
#import "CollectionsDetailCollectionViewCell.h"
#import "ToastService.h"
#import "CollectionsDetailCollectionViewCell+ConfigureCell.h"
#import "Collection.h"
#import "SplashControllerAccess.h"
#import "CollectionController.h"
#import "SPPhotoBrowserDelegate.h"
#import "Urls.h"    
#import "Photo.h"

@interface CollectionsDetailCollectionViewController() <CollectionDetailCellDelegate>
{
    CollectionController* _collectionController;
    NSMutableArray * _data;
    NSInteger _page;
    
    SPPhotoBrowserDelegate * _photoBrowserDelegate;
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
    _collectionController = SplashControllerAccess.collectionController;
    _data = [[NSMutableArray alloc]init];
    _page = 1;
    
    ActionButtonCallback actioncallback = ^(NSInteger index)
    {
        [self savePhotoAt: index];
    };
    
    _photoBrowserDelegate = [[SPPhotoBrowserDelegate alloc]initWithItems:self.navigationController
                                                    actionButtonCallback:actioncallback actionButton:true];
    
    // configure cell
    CellConfigureBlock configureCell = ^(CollectionsDetailCollectionViewCell *cell, Photo *photo)
    {
        [cell configureForPhoto: photo delegate: self];
    };
    
    // data source
    self.arrayDataSource = [[ArrayDataSource alloc] initWithItems:_data
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
    
    [_collectionController loadCollectionPhotos:_collection page:_page complete:^(NSArray * _Nullable data, NSError * _Nullable error)
    {
        if(error)
        {
            [weakSelf topBarMsg: [error localizedDescription]];
        }
        else
        {
            _page++;
            [weakSelf stopRefresh];
            
            for (Collection* item in data)
            {
                [_data addObject:item];
            }
            [self insertNewItems];
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

#pragma mark <UICollectionViewDelegate>, open photo browser
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* items = [self.arrayDataSource allItems];
    NSMutableArray* photos = [NSMutableArray new];
    NSUInteger first = items.count;
    for (NSUInteger i = first; i >= 1; i--)
    {
        Photo* p = [items objectAtIndex: i-1];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: [[p urls] regular]]]];
    }
    
    [_photoBrowserDelegate showPhotoBroswerWithArray:photos startIndex:indexPath.item];
}

#pragma mark download
-(void)savePhotoAt: (NSInteger)index
{
    [self topBarMsg: @"Downloading..."];
    
    Photo * photo = [self.arrayDataSource itemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [_collectionController requestDownload: photo];
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
