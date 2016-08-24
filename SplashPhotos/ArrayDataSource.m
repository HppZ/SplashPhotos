//
//  ArrayDataSource.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/24.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "ArrayDataSource.h"
#import "UICollectionView+NoData.h"


@interface ArrayDataSource ()

@property (nonatomic) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;

@end


@implementation ArrayDataSource

- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(CellConfigureBlock)ConfigureCellBlock
{
    self = [super init];
    if (self)
    {
        _items = anItems;
        _cellIdentifier = [aCellIdentifier copy];
        _configureCellBlock = [ConfigureCellBlock copy];
    }
    return self;
}

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
    [collectionView collectionViewDisplayWitMsg:@"pull to refresh" rowCount: self.items.count];
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item =  [self getItemWithIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

#pragma mark private
-(id)getItemWithIndexPath:(NSIndexPath*)indexPath
{
    if(indexPath != nil)
    {
        return  [self.items objectAtIndex: self.items.count -1 - indexPath.item];
    }
    return nil;
}

@end