//
//  CollectionsDetailCollectionViewLayout.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/31.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "CollectionsDetailCollectionViewLayout.h"
#import "ArrayDataSource.h"
#import "Photo.h"
#import "CellLayoutInfo.h"

@interface CollectionsDetailCollectionViewLayout()
{
    NSMutableArray * _cellLayoutInfoArray;
}
@end

@implementation CollectionsDetailCollectionViewLayout

#pragma mark layout
- (CGSize)collectionViewContentSize
{
    float contentWidth = self.collectionView.bounds.size.width;
    float contentHeight = [self contentHeight];
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    return contentSize;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    
    for (NSIndexPath *indexPath in visibleIndexPaths)
    {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self frameWithIndexPath:indexPath];
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds))
    {
        return YES;
    }
    return NO;
}

#pragma mark insert / delete
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
//    attributes.alpha = 0;
//    return attributes;
//
//}

//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

//    return attributes;
//}

#pragma mark helper
- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect
{
    NSArray *indexPaths = [self indexPathsInRect: rect];
    return indexPaths;
}


-(float)contentHeight
{
    _cellLayoutInfoArray = [[NSMutableArray alloc]init];
    
    ArrayDataSource * dataSource = self.collectionView.dataSource;
    NSArray * items = [dataSource allItems];
 
    float maxWidth = self.collectionView.bounds.size.width;
    float itemHeight = maxWidth/4;
    
    float lineWidth = 0;
    float totalHeight = itemHeight;

    NSInteger start = 0;
    for (NSInteger i = 0; i < items.count; i++)
    {
        Photo * photo = [dataSource itemAtIndexPath: [NSIndexPath indexPathForItem:i inSection:0]];
        double ratio = [photo.width floatValue] / [photo.height floatValue];
        CGSize itemSize = CGSizeMake(itemHeight * ratio, itemHeight);
        
        if (lineWidth + itemSize.width > maxWidth)
        {
            float leftWidth = maxWidth - lineWidth;
            
            totalHeight += itemHeight;
            
            lineWidth = itemSize.width;

            if (itemSize.width >= maxWidth)
            {
                [self arrangeLineWithStart:start end:i totalHeight:totalHeight - itemHeight itemHeight:itemHeight leftWidth: leftWidth maxWidth:self.collectionView.bounds.size.width];
                [self arrangeLineWithStart:i end:i+1 totalHeight:totalHeight itemHeight:itemHeight leftWidth:maxWidth - itemSize.width maxWidth:self.collectionView.bounds.size.width];
                
                totalHeight += itemSize.height;
                lineWidth = 0;
                start = i + 1;
            }
            else
            {
                [self arrangeLineWithStart:start end:i totalHeight:totalHeight - itemHeight itemHeight:itemHeight leftWidth:leftWidth maxWidth:self.collectionView.bounds.size.width];
                start = i;
            }
        }
        else
        {
            lineWidth += itemSize.width;
        }
    }
    
    if(lineWidth > 0)
    {
        [self arrangeLineWithStart:start end: items.count totalHeight:totalHeight itemHeight:itemHeight leftWidth:0 maxWidth:self.collectionView.bounds.size.width];
    }
    
    return totalHeight;
}

// 不包含end
-(void)arrangeLineWithStart: (NSInteger)start end: (NSInteger)end totalHeight: (float) totalHeight itemHeight: (float)itemHeight leftWidth: (float)leftWidth maxWidth: (float)maxwidth
{
    if(start >  end) return;
    
    float horizontalOffset = 0.0;
    ArrayDataSource *dataSource = self.collectionView.dataSource;
    
    float w = leftWidth / (end - start);
    for (NSInteger i = start; i < end; i++)
    {
        NSIndexPath * index = [NSIndexPath indexPathForItem: i inSection:0];
        
        Photo * photo = [dataSource itemAtIndexPath: index];
        double ratio = [photo.width floatValue] / [photo.height floatValue];
        CGSize elementSize = CGSizeMake(itemHeight * ratio + w, itemHeight);
        
        CGRect  frame = CGRectMake(horizontalOffset, totalHeight - itemHeight, elementSize.width, elementSize.height);
        
        if(frame.origin.x + frame.size.width > maxwidth)
        {
            if(frame.size.width > maxwidth)
            {
                frame.origin.x  = 0;
                frame.size.width = maxwidth;
            }
            else
            {
                float t =  (frame.origin.x + frame.size.width - maxwidth);
                //frame.origin.x  -= t;
                frame.size.width -= t;
            }
        }

        [self addCellLayoutInfo:index frame:frame];
        horizontalOffset += elementSize.width;
    }
}


-(void)addCellLayoutInfo: (NSIndexPath*) indexPath frame: (CGRect) frame
{
    [_cellLayoutInfoArray addObject:[[CellLayoutInfo alloc] initWithIndexPath:indexPath frame:frame]];
}

-(CGRect)frameWithIndexPath: (NSIndexPath*)indexpath
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(indexPath.item == %i)", indexpath.item];
    NSArray *filtered = [_cellLayoutInfoArray filteredArrayUsingPredicate:pred];
    CellLayoutInfo * info = [filtered lastObject];
    return info.frame;
}

-(NSArray*)indexPathsInRect: (CGRect)rect
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    
     NSPredicate * pred = [NSPredicate predicateWithBlock:
                           ^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings)
    {
        CellLayoutInfo* info = evaluatedObject;
        return !CGRectIsNull(CGRectIntersection(rect, info.frame));
    }];
                           
    NSArray *filtered = [_cellLayoutInfoArray filteredArrayUsingPredicate:pred];
    for (CellLayoutInfo * info in filtered)
    {
        [indexPaths addObject:info.indexPath];
    }
    
    return indexPaths;
}

@end
