//
//  LeftViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/18.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "LeftViewController.h"
#import "Category.h"
#import "UIViewController+HPSideMenu.h"
#import "SplashControllerAccess.h"
#import "CategoryController.h"
#import "InitViewController.h"

@interface LeftViewController ()
{
    CategoryController * _categoryController;
    NSMutableArray<Category *>* _data;
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
    [self loadData];
}

-(float)yPosition
{
    return (self.view.frame.size.height - 54 * 6) / 2.0f;
}

-(void)setup
{
    _categoryController = SplashControllerAccess.categoryController;
    _data = [[NSMutableArray alloc]init];
}

-(void)loadData
{
    [_categoryController loadCategories:^(NSArray * _Nullable data, NSError * _Nullable error)
     {
         if(error)
         {
             
         }
         else
         {
             [_data removeAllObjects];
             for (Category* item in data)
             {
                 [_data addObject:item];
             }
             [self.tableView reloadData];
         }
     }];
}

#pragma mark tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Category* category = [_data objectAtIndex:indexPath.item];
    InitViewController * vc = (InitViewController *)self.parentViewController;
    [vc navigateTo:category];
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
    [self tableViewDisplayWithRowCount: _data.count];
    return _data.count;
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
    
    cell.textLabel.text = [_data objectAtIndex:indexPath.item].title;
    
    return cell;
}

#pragma mark nodata
- (void) tableViewDisplayWithRowCount:(NSUInteger) rowCount
{
    BOOL flag = _data.count <= 0;
    _reloadButton.hidden = !flag;
}

- (IBAction)reloadClicked:(id)sender
{
    [self loadData];
}
@end
