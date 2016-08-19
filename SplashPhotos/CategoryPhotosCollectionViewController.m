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
#import "PhotoService.h"
#import "JDStatusBarNotification.h"
#import "CategoryCollectionViewCell.h"

@interface CategoryPhotosCollectionViewController()
{
    UIButton *loadmorebutton;
    UIActivityIndicatorView *loadingindicator;
    
    NSMutableArray<Photo *>* _categoryPhotos;
    PhotoService * _photoService;
    NSMutableArray *_photosForBrowsing;
}
@end

@implementation CategoryPhotosCollectionViewController


static NSString * const reuseIdentifier = @"categoryPhotoCell";

#pragma mark view setup
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self loadData];
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
    _photoService = [[PhotoService alloc] init];
    _categoryPhotos  = [_photoService getPhotosInCurrentCategory];
    _photosForBrowsing = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:[PhotoService photosInCategoryChangedNotification]
                                               object:nil];
    
}

#pragma mark 通知
- (void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString: [PhotoService photosInCategoryChangedNotification]])
    {
        [self insertNewItems];
    }
}

#pragma mark - data
-(void)loadData
{
    [self showLoadingring:true];
    
    __weak CategoryPhotosCollectionViewController * weakSelf = self;
    
    [_photoService loadPhotosInCurrentCategoryWithCallback:^(NSString *errormsg)
    {
        [weakSelf showLoadingring:false];
        
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
    NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    NSInteger max = _categoryPhotos.count;
    for (NSInteger i = count; i <  max; i++)
    {
        [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow: i inSection:0]];
    }
    [self.collectionView insertItemsAtIndexPaths: arrayWithIndexPaths];
}

#pragma mark IBAction
- (IBAction)loadMoreClicked:(UIButton *)sender
{
    [self loadData];
}

#pragma mark UI 设置
-(void)showLoadingring:(bool) show
{
    if(!show)
    {
        [loadingindicator stopAnimating];
    }
    else
    {
        [loadingindicator startAnimating];
    }
    
    [loadingindicator setHidden:!show];
    [loadmorebutton setHidden:show];
}

-(void)navBarTitle
{
    int pagenum = [_photoService getCurrentCategoryPageNum];
    NSString* name = [_photoService getCurrentCategoryName];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ (P %d)" ,name,pagenum];
}

-(void)showPop:(NSString*)text
{
    [JDStatusBarNotification showWithStatus:text dismissAfter: 1];
}

#pragma mark MWPhotoBrowser
-(void)cellClicked: (long) pos
{
    [_photosForBrowsing removeAllObjects];
    
    for (Photo *photo in _categoryPhotos)
    {
        [_photosForBrowsing addObject:[MWPhoto photoWithURL:[NSURL URLWithString: [[photo urls] regular]]]];
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
    [browser setCurrentPhotoIndex: pos];
    
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
    
    Photo * photo =  [_categoryPhotos objectAtIndex:photoBrowser.currentIndex] ;
    [_photoService requestDownload: photo];
}

#pragma mark <UICollectionViewDataSource>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *footerview;
    if (kind == UICollectionElementKindSectionFooter)
    {
        footerview = [self.collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"categoryPhotosFooter" forIndexPath: indexPath];
        
        loadmorebutton = [footerview viewWithTag:3];
        loadingindicator = [footerview viewWithTag:4];
    }
    return footerview ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _categoryPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Photo *photo =  [_categoryPhotos objectAtIndex:indexPath.item];
    [cell cellThumb:[[photo urls] small ]];
    
    return cell;
}

#pragma mark 点击图片 <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self cellClicked: indexPath.item];
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
