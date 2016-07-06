//
//  LSChartView.h
//  LifeHelper
//
//  Created by Lost_souls on 16/6/21.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSChartView;
@protocol LSChartViewDataSource <NSObject>

@required
/** 横坐标 label */
- (NSArray *)chartViewHorizontalTitles:(LSChartView *)chartView;
/** 纵坐标 label */
- (NSArray *)chartViewVerticalTitles:(LSChartView *)chartView;
@optional
/** 网格线颜色 默认greenColor */
- (UIColor *)backgroundLineColor;
/** 网格线粗细 默认 2.f */
- (CGFloat)backgroundLineWidth;

@end


@interface LSChartView : UIView



#pragma mark -
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

/**
 *  初始化方法
 *
 *  @param frame      frame
 *  @param dataSource @see LSChartViewDataSource
 *
 *  @return LSChartView
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<LSChartViewDataSource>)dataSource ;

/**
 *  显示<开始画线>
 *
 *  @param view UIView
 */
- (void)showInView:(UIView *)view points:(NSArray *)points;

/**
 *  刷新
 *
 *  @param points @[数据点]
 */
- (void)reloadData:(NSArray *)points;

@end



#pragma mark - LSBrokenLineView

@interface LSBrokenLineView : UIView

@property (strong,nonatomic) UIColor *chartPointColor;
@property (assign,nonatomic) CGFloat chartPointRadius;
@property (assign,nonatomic) CGFloat chartLineWidth;
@property (strong,nonatomic) UIColor *chartLineColor;
@property (assign,nonatomic) BOOL isHollow;
@property (assign,nonatomic) BOOL isShowMaxAndMin;

- (instancetype)initWithFrame:(CGRect)frame xList:(NSArray *)xList yList:(NSArray *)yList textColor:(UIColor *)textColor textFont:(UIFont *)textFont lineMarginVertical:(CGFloat)lineMarginVertical;

-(void)strokeChart:(NSArray *)_yValues;

@end


#pragma mark - LSGrideView

@interface LSGrideView : UIView

- (instancetype)initWithFrame:(CGRect)frame xList:(NSArray *)xList yList:(NSArray *)yList color:(UIColor *)lineColor width:(CGFloat)lineWidth;

@end




