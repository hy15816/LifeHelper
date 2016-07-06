//
//  UIScrollView+PlaceholderView.h
//  LifeHelper
//
//  Created by Lost_souls on 16/7/2.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaceholderViewDataSource;
@protocol PlaceholderViewDelegate;

@interface UIScrollView (PlaceholderView)

@property (assign,nonatomic) id<PlaceholderViewDataSource> datasource;
@property (assign,nonatomic) id<PlaceholderViewDelegate> delegate;

@property (nonatomic, readonly, getter = isPlaceholderVisible) BOOL placeholderVisible;

- (void)reloadPlaceholderView;

@end



@protocol PlaceholderViewDataSource <NSObject>
@optional
// 标题
- (NSAttributedString *)placeholderViewForTitle:(UIScrollView *)scrollView;
// button 标题
- (NSAttributedString *)placeholderViewForButton:(UIScrollView *)scrollView;

- (UIImage *)placeholderViewForImage:(UIScrollView *)scrollView;

- (UIColor *)placeholderViewForBackgroundColor:(UIScrollView *)scrollView;


@end

@protocol PlaceholderViewDelegate <NSObject>
@optional
- (BOOL)placeholderViewShouldAllowScroll:(UIScrollView *)scrollView;
- (BOOL)placeholderViewShouldAllowTouch:(UIScrollView *)scrollView;

- (void)placeholderView:(UIScrollView *)scrollView didTapButton:(UIButton *)button;
- (void)placeholderView:(UIScrollView *)scrollView didTapView:(UIView *)view;


@end
