//
//  ArrayDataSource.h
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/24.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CellConfigureBlock)(id cell, id item);

@interface ArrayDataSource : NSObject<UICollectionViewDataSource, UITableViewDataSource>

@property (nonatomic) BOOL isReverse;

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(CellConfigureBlock)ConfigureCellBlock
          noDataTip: (NSString*) noData;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (id)allItems;

@end
