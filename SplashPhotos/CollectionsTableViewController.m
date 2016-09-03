//
//  CollectionsTableViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsTableViewController.h"
#import "SplashControllerAccess.h"
#import "ArrayDataSource.h"
#import "CollectionsTableViewCell.h"
#import "Collection.h"
#import "CollectionsTableViewCell+ConfigureCell.h"
#import "ToastService.h"
#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import "UserProfileViewController.h"
#import "CollectionsDetailCollectionViewController.h"
#import "CollectionController.h"
#import "User.h"

@interface CollectionsTableViewController()
{
    CollectionController* _collectionController;
    NSMutableArray * _data;
    NSInteger _page;
    BOOL _loaded;
}

@property ArrayDataSource* arrayDataSource;

@end

@implementation CollectionsTableViewController

static NSString * const reuseIdentifier = @"collectionTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    _loaded = false;
}

-(void)viewWillAppear:(BOOL)animated
{
    // pull to refresh
    __weak typeof(self) weakSelf =self;
    [self.tableView addPullToRefreshActionHandler:
     ^{
         typeof(self) strongSelf = weakSelf;
         [strongSelf loadData];
     }
                            ProgressImagesGifName:@"spinner_dropbox@2x.gif"
                             LoadingImagesGifName:@"run@2x.gif"
                          ProgressScrollThreshold:60
                            LoadingImageFrameRate:30];
    
    if(!_loaded)
    {
        _loaded = true;
        [self triggerPullToRefresh];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setup
{
    // init
    _collectionController = SplashControllerAccess.collectionController;
    _data = [[NSMutableArray alloc]init];
    _page = 1;
    
    // configure cell
    CellConfigureBlock configureCell = ^(CollectionsTableViewCell *cell, Collection *collection)
    {
        [cell configureForPhoto:collection delegate: self];
    };
    
    // data source
    self.arrayDataSource = [[ArrayDataSource alloc] initWithItems:_data
                                                   cellIdentifier:reuseIdentifier
                                               configureCellBlock:configureCell
                                                        noDataTip:@"pull to refresh"];
    self.arrayDataSource.isReverse = true;
    self.tableView.dataSource = self.arrayDataSource;
}

#pragma mark - data
-(void)loadData
{
    __weak CollectionsTableViewController * weakSelf = self;
    [_collectionController loadCollections:_page complete:^(NSArray * _Nullable data, NSError * _Nullable error)
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
    NSInteger count = [self.tableView numberOfRowsInSection:0];
    NSInteger max = ((NSArray*)[self.arrayDataSource allItems]).count - count;
    
    NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
    for (NSInteger i = 0; i <  max; i++)
    {
        [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow: i inSection:0]];
    }
    [self.tableView  insertRowsAtIndexPaths:arrayWithIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark UI helper
-(void)stopRefresh
{
    [self.tableView stopPullToRefreshAnimation];
}

-(void)triggerPullToRefresh
{
    [self.tableView triggerPullToRefresh];
}

-(void)navBarTitle
{
    self.navigationItem.title = [NSString stringWithFormat:@"%@" ,@"COLLECTION"];
}

-(void)topBarMsg:(NSString*)text
{
    [ToastService showToastWithStatus:text];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
}

#pragma mark CollectionsTableViewCellDelegate
-(void)collectionClicked:(CollectionsTableViewCell*)cell sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath != nil)
    {
        Collection  *  collection = [self.arrayDataSource itemAtIndexPath:indexPath];
        if(collection)
        {
            [self navigateToCollectionDetail:collection];
        }
    }
    else
    {
        assert(0);
    }
}

-(void)userClicked:(CollectionsTableViewCell*)cell sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath != nil)
    {
        Collection  *  collection = [self.arrayDataSource itemAtIndexPath:indexPath];
        if(collection)
        {
            [self navigateToUserProfile: collection.user.username];
        }
    }
    else
    {
        assert(0);
    }
}

#pragma mark navigation
-(void)navigateToCollectionDetail: (Collection*) collection
{
    CollectionsDetailCollectionViewController* vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"collectionDetailViewController"];
    vc.collection = collection;
    [self.navigationController pushViewController:vc animated:true];
}

-(void)navigateToUserProfile: (NSString*) username
{
    UserProfileViewController* vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"userProfileViewController"];
    vc.userName = username;
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark dealloc
-(void)dealloc
{

}
@end
