//
//  CollectionsTableViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/29.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsTableViewController.h"
#import "PhotoService.h"
#import "ArrayDataSource.h"
#import "CollectionsTableViewCell.h"
#import "Collection.h"
#import "CollectionsTableViewCell+ConfigureCell.h"
#import "ToastService.h"
#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import "UserProfileViewController.h"
#import "CollectionsDetailCollectionViewController.h"


@interface CollectionsTableViewController()
{
    PhotoService* _photoService;
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
    _photoService = [[PhotoService alloc] init];
    
    // get photos data
    NSMutableArray *collections  = [_photoService getCollections];
    
    // configure cell
    CellConfigureBlock configureCell = ^(CollectionsTableViewCell *cell, Collection *collection)
    {
        [cell configureForPhoto:collection delegate: self];
    };
    
    // data source
    self.arrayDataSource = [[ArrayDataSource alloc] initWithItems:collections
                                                   cellIdentifier:reuseIdentifier
                                               configureCellBlock:configureCell
                                                        noDataTip:@"pull to refresh"];
    self.arrayDataSource.isReverse = true;
    self.tableView.dataSource = self.arrayDataSource;
   
    // notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:[PhotoService collectionsChangedNotification]
                                               object:nil];
}

#pragma mark notification
- (void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString: [PhotoService collectionsChangedNotification]])
    {
        [self insertNewItems];
    }
}

#pragma mark - data
-(void)loadData
{
    __weak CollectionsTableViewController * weakSelf = self;
    
    [_photoService loadMoreCollectionsWithCallbak:^(NSString *errormsg)
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
  //  int pagenum = [_photoService getCollectionsPageNum];
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
        NSLog(@"userClicked indexpath nil");
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
        NSLog(@"userClicked indexpath nil");
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
