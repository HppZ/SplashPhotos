//
//  CategoryPhotosCollectionViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/19.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CategoryPhotosCollectionViewController.h"
#import "Photo.h"
#import "Urls.h"
#import "SplashControllerAccess.h"
#import "CategoryCollectionViewCell.h"
#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import "ToastService.h"
#import "SPPhotoBrowserDelegate.h"
#import "ArrayDataSource.h"
#import "CategoryCollectionViewCell+ConfigureCell.h"
#import "CategoryController.h"
#import "Category.h"
#import "PhotoController.h"

@interface CategoryPhotosCollectionViewController()
{
    CategoryController * _categoryController;
    NSMutableArray * _data;
    NSInteger _page;

}

@property SPPhotoBrowserDelegate* photoBrowserDelegate;
@property ArrayDataSource* arrayDataSource;

@end

@implementation CategoryPhotosCollectionViewController


static NSString * const reuseIdentifier = @"categoryPhotoCell";

#pragma mark view setup
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self triggerPullToRefresh];
}

-(void)viewWillLayoutSubviews
{
    float w = (self.collectionView.frame.size.width - 3.5 ) / 4;
    ((UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout).itemSize = CGSizeMake(w,w);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup
{
    // configure photo browser
    ActionButtonCallback actioncallback = ^(NSInteger index)
    {
        [self savePhotoAt: index];
    };
    
    _photoBrowserDelegate = [[SPPhotoBrowserDelegate alloc]initWithItems:self.navigationController
                                                    actionButtonCallback:actioncallback actionButton:true];
    
    _categoryController = SplashControllerAccess.categoryController;
    _data = [[NSMutableArray alloc]init];
    _page = 1;
    
    // configure cell
    CellConfigureBlock configureCell = ^(CategoryCollectionViewCell *cell, Photo *photo)
    {
        [cell configureForPhoto:photo];
    };
    
    // data source
    self.arrayDataSource = [[ArrayDataSource alloc] initWithItems: _data
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
    __weak CategoryPhotosCollectionViewController * weakSelf = self;
    
    [_categoryController loadCategoryPhotos: _category page:_page complete:^(NSArray * _Nullable data, NSError * _Nullable error)
     {
         [weakSelf stopRefresh];
         if(error)
         {
             [weakSelf topBarMsg: [error localizedDescription]];
         }
         else
         {
             _page++;
             [weakSelf navBarTitle];
             
             for (Photo* item in data)
             {
                 [_data addObject:item];
             }
             [self insertNewItems];
         }
    }];
}

-(void)insertNewItems
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    NSInteger max = ((NSArray*)[self.arrayDataSource allItems]).count - count;
    
    NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
    for (NSInteger i = 0; i <  max; i++)
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
    self.navigationItem.title = [NSString stringWithFormat:@"%@" ,[_category.title uppercaseString]];
}

-(void)topBarMsg:(NSString*)text
{
    [ToastService showToastWithStatus:text];
}

#pragma mark UICollectionViewDelegate, open photo browser
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* items = [self.arrayDataSource allItems];
    NSMutableArray* photos = [NSMutableArray new];
    NSUInteger first = items.count;
    for (NSUInteger i = first; i >= 1; i--)
    {
        Photo* p = [items objectAtIndex: i-1];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString: [[p urls] small]]]];
    }
    
    [_photoBrowserDelegate showPhotoBroswerWithArray:photos startIndex:indexPath.item];
}

#pragma mark download
-(void)savePhotoAt: (NSInteger)index
{
    [self topBarMsg: @"Downloading..."];
    
    Photo * photo = [self.arrayDataSource itemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [SplashControllerAccess.photoController requestDownload: photo];
}

#pragma mark dealloc
-(void)dealloc
{

}

@end
