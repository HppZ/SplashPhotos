//
//  LeftViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/18.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "LeftViewController.h"
#import "UIViewController+RESideMenu.h"
#import "PhotoService.h"
#import "Category.h"

@interface LeftViewController ()
{
    PhotoService * _photoService;
    NSArray<Category*>* _categories;
}

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;

@end

@implementation LeftViewController

#pragma mark setup
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    
    self.tableView =
    ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [self yPosition], self.view.frame.size.width, self.view.frame.size.height - [self yPosition]) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });
    
    [self.view insertSubview:self.tableView belowSubview:_reloadButton];
}

-(float)yPosition
{
    return (self.view.frame.size.height - 54 * 6) / 2.0f;
}

-(void)setup
{
    _photoService = [[PhotoService alloc] init];
    _categories = [_photoService getCategories];
}

-(void)loadData
{
    [_photoService requestCategoriesWithCallback:^(NSString *errormsg)
     {
        if(!errormsg)
        {
            [self.tableView reloadData];
        }
    }];
}

#pragma mark tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:  indexPath];
    NSString* name = cell.textLabel.text;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"navigate" object:self userInfo: dic];
    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    [self tableViewDisplayWithRowCount: _categories.count];
    return _categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"whatever";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    cell.textLabel.text = [_categories  objectAtIndex:indexPath.item].title;
    
    return cell;
}

#pragma mark nodata
- (void) tableViewDisplayWithRowCount:(NSUInteger) rowCount
{
    BOOL flag = rowCount <= 0;
    _reloadButton.hidden = !flag;
}

- (IBAction)reloadClicked:(id)sender
{
    [self loadData];
}
@end
