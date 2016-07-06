//
//  ChartGrideView.h
//  LifeHelper
//
//  Created by Lost_souls on 16/6/20.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChartGrideView;
@protocol ChartGrideViewDataSource <NSObject>
@required
/** 横坐标 label */
- (NSArray *)chartViewHorizontalTitles:(ChartGrideView *)chartView;
/** 纵坐标 label */
- (NSArray *)chartViewVerticalTitles:(ChartGrideView *)chartView;
@optional
/** 网格线颜色 默认greenColor */
- (UIColor *)backgroundLineColor;
/** 网格线粗细 默认 2.f */
- (CGFloat)backgroundLineWidth;

@end

@interface ChartGrideView : UIView


- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<ChartGrideViewDataSource>)dataSource ;

/**
 *  显示<开始画线>
 *
 *  @param view UIView
 */
- (void)showInView:(UIView *)view points:(NSArray *)points;

- (void)reloadData:(NSArray *)points;

#pragma mark - m
/**
 *  label 颜色
 */
@property (strong,nonatomic) UIColor *textColor;
/**
 *  label 字体
 */
@property (strong,nonatomic) UIFont *textFont;

/**
 *  折线颜色
 */
@property (strong,nonatomic) UIColor *chartLineColor;
/**
 *  折线粗细  df=2.0
 */
@property (assign,nonatomic) CGFloat chartLineWidth;

/**
 *  小圆点半径
 */
@property (assign,nonatomic) CGFloat chartPointRadius;
/**
 *  小圆点颜色
 */
@property (strong,nonatomic) UIColor *chartPointColor;
/**
 *  是否空心
 */
@property (assign,nonatomic) BOOL isHollow;

/**
 *  标记最大值最小值
 */
@property (assign,nonatomic) BOOL isShowMaxAndMin;



@end





