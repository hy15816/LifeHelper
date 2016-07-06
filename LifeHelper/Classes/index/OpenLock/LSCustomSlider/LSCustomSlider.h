//
//  LSCustomSlider.h
//  anxindian
//
//  Created by Lost_souls on 16/5/19.
//  Copyright © 2016年 anerfa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSCustomSlider;
@protocol LSCustomSliderDelegate <NSObject>
@optional;
- (void)slider:(LSCustomSlider *)slider valueChanged:(CGFloat)value;
- (void)sliderValueChangeEnd:(LSCustomSlider *)slider;

@end

@interface LSCustomSlider : UIView


/**
 *  滑块 view
 */
@property (strong,nonatomic) UIView *thumbView;
/**
 *  滑块滑过的值
 */
@property (nonatomic, assign) float value;
/**
 *  背景图片
 */
@property (strong,nonatomic) UIImage *backgroundImage;

@property (strong,nonatomic) UIImage *centerViewImage1;
@property (strong,nonatomic) UIImage *centerViewImage2;

/**
 *  滑块图片
 */
@property (strong,nonatomic) UIImage *thumbImage;
/**
 *  滑动完成部分的颜色
 */
@property (strong,nonatomic) UIColor *foregroundColor;
/**
 *  背景显示的文字
 */
@property (strong,nonatomic) NSString *text;
/**
 *  字体
 */
@property (strong,nonatomic) UIFont *textFont;
/**
 *  字体颜色
 */
@property (strong,nonatomic) UIColor *textColor;
/**
 *  滑动完成显示背景文字
 */
@property (assign,nonatomic) BOOL showTextComplete;

@property (assign,nonatomic) id<LSCustomSliderDelegate> delegate;

- (void)setValue:(float)value animation:(bool)animate completion:(void (^)(BOOL finished))completion;
//- (void)setValue:(float)value completion:(void (^)(BOOL finished))completion;
- (void)setBackgroundColor:(UIColor *)bgColor foreground:(UIColor *)fColor handle:(UIColor *)hCol border:(UIColor *)brdrCol;


@end
