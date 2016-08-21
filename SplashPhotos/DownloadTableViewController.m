//
//  DownloadViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/6.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "DownloadTableViewController.h"
#import "DownloadPhoto.h"
#import "PhotoService.h"
#import "DownloadTableViewCell.h"
#import "ToastService.h"
#import "UITableView+NoData.h"

@interface DownloadTableViewController ()
{
    PhotoService* _photoService;
    NSMutableArray * _downloadPhotos;
    NSMutableArray* _phototoscan;
}
@end

@implementation DownloadTableViewController

#pragma mark view setup
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setup
{
    _photoService = [[PhotoService alloc] init];
    _downloadPhotos = [_photoService  getDownloadDataSource];
    _phototoscan  = [[NSMutableArray alloc] init];
    self.tableView.rowHeight = 62;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:[PhotoService downloadSourceChangedNotification]
                                               object:nil];
}

#pragma mark 通知
- (void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString: [PhotoService downloadSourceChangedNotification]])
    {
        [self insertNewItems];
    }
}

#pragma mark data
-(void)insertNewItems
{
    NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
    NSInteger count = [self.tableView numberOfRowsInSection:0];
    
    NSInteger max = _downloadPhotos.count - count;
    for (NSInteger i = 0; i <  max; i++)
    {
        [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow: i inSection:0]];
    }
    [self.tableView  insertRowsAtIndexPaths:arrayWithIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark 重新下载
- (void)didClickOnCell:(DownloadTableViewCell*)cell sender:(id)sender;
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath != nil)
    {
        DownloadPhoto* downloadPhoto = [_downloadPhotos objectAtIndex:indexPath.item];
        if(downloadPhoto)
        {
            [_photoService restartDownload:downloadPhoto];
        }
    }
    else
    {
        assert(0);
        NSLog(@"restart indexpath nil");
    }
}

#pragma mark 查看图片
-(void)cellClicked: (long) pos
{
    [_phototoscan removeAllObjects];
    
    DownloadPhoto * photo = [_downloadPhotos objectAtIndex:pos];
    if(!photo.downloadSucceed )
    {
        [self showPop:@"not now"];
        return;
    }
    
    for (DownloadPhoto* photo in _downloadPhotos)
    {
        if( photo.downloadSucceed)
        {
            NSString* url = photo.filepath;
            [_phototoscan addObject: [MWPhoto photoWithURL:[NSURL URLWithString:  url]]];
        }
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
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

#pragma mark MWPhotoBrowser
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _phototoscan.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _phototoscan.count) {
        return [_phototoscan objectAtIndex:index];
    }
    return nil;
}

#pragma mark 文字提示
-(void)showPop:(NSString*)text
{
     [ToastService showToastWithStatus:text];
}

-(void)navBarTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.tableView tableViewDisplayWitMsg:@"go download a photo" rowCount:_downloadPhotos.count];
    return _downloadPhotos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadTableViewCell" forIndexPath:indexPath];
    DownloadPhoto *photo =  [_downloadPhotos objectAtIndex:indexPath.item];
    [cell cellThumb:[photo thumb]];
    [cell cellProgress: [photo proress]];
    [cell cellDownloadState: photo.downloadState];
    [cell setDelegate:self];
//    [cell.restartButton addTarget:self
//                           action:@selector(downloadTableviewCellRestartButtonPressed:event:)
//                 forControlEvents:UIControlEventTouchUpInside];
    
    [photo addObserver:cell
            forKeyPath:@"proress"
               options:NSKeyValueObservingOptionNew
               context:NULL];
    [photo addObserver:cell
            forKeyPath:@"downloadState"
               options:NSKeyValueObservingOptionNew
               context:NULL];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cellClicked:indexPath.item];
}

#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
