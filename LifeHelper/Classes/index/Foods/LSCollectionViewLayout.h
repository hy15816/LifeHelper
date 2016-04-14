//
//  LSCollectionViewLayout.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/7.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCollectionViewLayout : UICollectionViewLayout

/**
 *  cell左右之间的距离(df = 10)
 */
@property (assign,nonatomic) CGFloat cellMarginTop;
/**
 *  cell上下之间的距离(df = 10)
 */
@property (assign,nonatomic) CGFloat cellMarginLeft;
/**
 *  cell上下左右之间的距离(df = {10,10,10,10})
 */
@property (assign,nonatomic) UIEdgeInsets edgeInsets;
/**
 *  列数(每行个数，df = 3)
 */
@property (assign,nonatomic) NSInteger columns;

/**
 *  cell的最小高度(df = 60)
 */
@property (assign,nonatomic) CGFloat cellMinHeight;

/**
 *  cell的最大高度(df = 150)
 */
@property (assign,nonatomic) CGFloat cellMaxHeight;

@end
