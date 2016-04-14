//
//  LSCollectionViewLayout.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/7.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "LSCollectionViewLayout.h"

/** 每一行之间的间距 */
static  CGFloat LSDefaultRowMargin = 10;
/** 每一列之间的间距 */
static  CGFloat LSDefaultColumnMargin = 10;
/** 每一列之间的间距 top, left, bottom, right */
static  UIEdgeInsets LSDefaultInsets = {10, 10, 10, 10};
/** 默认的列数 */
static  NSInteger LSDefaultColumsCount = 3;

static CGFloat LSDefaultCellMinH = 50;

static CGFloat LSDefaultCellMaxH = 150;


@interface LSCollectionViewLayout ()
/**
 *  每一列的最大y值
 */
@property (strong, nonatomic) NSMutableArray *columnMaxYs;
@property (strong, nonatomic) NSMutableArray *cellAttrsArray;

@end

@implementation LSCollectionViewLayout



-(CGSize)collectionViewContentSize {
    
    CGFloat destMaxY = [[self.columnMaxYs firstObject] doubleValue];
    
    for (NSString *stringY in self.columnMaxYs) {
        CGFloat columnMaxY = [stringY doubleValue];
        // 找出数组中的最大值
        if (destMaxY < columnMaxY) {
            destMaxY = columnMaxY;
        }
    }
    
    return CGSizeMake(0, destMaxY + LSDefaultInsets.bottom);
}

- (void)prepareLayout {
    
    [super prepareLayout];
    
    [self.columnMaxYs removeAllObjects];
    
    for (int i=0; i< LSDefaultColumsCount; i++) {
        [self.columnMaxYs addObject:@(LSDefaultInsets.top)];
    }
    
    // 计算所有cell的布局
    [self.cellAttrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger j = 0; j < count; j ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.cellAttrsArray addObject:attrs];
    }
    
}

/**
 * 说明cell的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /** 计算indexPath位置cell的布局属性 */
    
    // 水平方向上的总间距
    CGFloat xMargin = LSDefaultInsets.left + LSDefaultInsets.right + (LSDefaultColumsCount - 1) * LSDefaultColumnMargin;
    // cell的宽度
    CGFloat w = (DEVICE_WIDTH - xMargin) / LSDefaultColumsCount;
    // cell的高度，测试数据，随机数
    CGFloat random = LSDefaultCellMaxH - LSDefaultCellMinH;
    CGFloat h = LSDefaultCellMinH + arc4random_uniform(random);
    
    // 找出最短那一列的 列号 和 最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    NSUInteger destColumn = 0;
    for (NSUInteger i = 1; i<self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        // 找出数组中的最小值
        if (destMaxY > columnMaxY) {
            destMaxY = columnMaxY;
            destColumn = i;
        }
    }
    
    // cell的x值
    CGFloat x = LSDefaultInsets.left + destColumn * (w + LSDefaultColumnMargin);
    // cell的y值
    CGFloat y = destMaxY + LSDefaultRowMargin;
    // cell的frame
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新数组中的最大Y值
    self.columnMaxYs[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}

/**
 * 说明所有元素（比如cell、补充控件、装饰控件）的布局属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.cellAttrsArray;
}



- (NSMutableArray *)columnMaxYs {
    if (_columnMaxYs == nil) {
        _columnMaxYs = [[NSMutableArray alloc] init];
    }
    
    return _columnMaxYs;
}

- (NSMutableArray *)cellAttrsArray {
    
    if (_cellAttrsArray == nil) {
        _cellAttrsArray = [[NSMutableArray alloc] init];
    }
    
    return _cellAttrsArray;
    
}


-(void)setCellMarginTop:(CGFloat)cellMarginTop {
    
    _cellMarginTop = cellMarginTop;
    LSDefaultRowMargin = cellMarginTop;
    
}

- (void)setColumns:(NSInteger)columns {
    
    _columns = columns;
    LSDefaultColumsCount = columns;
    
}

-(void)setCellMarginLeft:(CGFloat)cellMarginLeft{
    _cellMarginLeft = cellMarginLeft;
    LSDefaultColumnMargin = cellMarginLeft;
    
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    
    _edgeInsets = edgeInsets;
    LSDefaultInsets = edgeInsets;
    
}


- (void)setCellMinHeight:(CGFloat)cellMinHeight {
    
    _cellMinHeight = cellMinHeight;
    LSDefaultCellMinH = cellMinHeight;
}

- (void)setCellMaxHeight:(CGFloat)cellMaxHeight {
    
    _cellMaxHeight = cellMaxHeight;
    LSDefaultCellMaxH = cellMaxHeight;
}

@end
