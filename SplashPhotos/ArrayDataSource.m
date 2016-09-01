//
//  ArrayDataSource.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/24.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "ArrayDataSource.h"
#import "UICollectionView+NoData.h"
#import "UITableView+NoData.h"

@interface ArrayDataSource ()

@property (nonatomic) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;
@property (nonatomic, copy) NSString* nodata;
@end

@implementation ArrayDataSource

#pragma mark init
- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(CellConfigureBlock)ConfigureCellBlock
          noDataTip: (NSString*) noData
{
    self = [super init];
    if (self)
    {
        _items = anItems;
        _cellIdentifier = [aCellIdentifier copy];
        _configureCellBlock = [ConfigureCellBlock copy];
        _nodata = [noData copy];
        _isReverse = false;
    }
    return self;
}

#pragma mark public
- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getItemWithIndexPath: indexPath];
}

-(id)allItems
{
    return self.items;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [collectionView collectionViewDisplayWitMsg: self.nodata rowCount: self.items.count];
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item =  [self getItemWithIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableViewDisplayWitMsg: self.nodata rowCount:self.items.count];
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: self.cellIdentifier forIndexPath:indexPath];
    id item =  [self getItemWithIndexPath : indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

#pragma mark private
-(id)getItemWithIndexPath:(NSIndexPath*)indexPath
{
    if(indexPath != nil)
    {
        return  [self.items objectAtIndex: _isReverse? (self.items.count -1 - indexPath.item) :indexPath.item ];
    }
    return nil;
}

@end