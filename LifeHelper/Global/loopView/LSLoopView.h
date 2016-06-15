//
//  LSLoopViews.h
//  ActionSheet
//
//  Created by AEF-RD-1 on 15/10/23.
//  Copyright (c) 2015年 hyIm. All rights reserved.
//  图片滚动

//#define LSLoopDeprecated(instead) NS_DEPRECATED(instead)


#import <UIKit/UIKit.h>

@class LSLoopView;
@protocol LSLoopViewDelegate <NSObject>
@optional
/**
 *  点击了哪张图片,
 *
 *  @param loopView current LoopView
 *  @param index    item index
 */
- (void)loopView:(LSLoopView *)loopView didSelectItem:(NSInteger)index;

@end

typedef void(^didSelectedIndex)(LSLoopView *loopView,NSInteger index);

@interface LSLoopView : UIView
/**
 *  滚动时间间隔，df 1.5s
 */
@property (assign,nonatomic) CGFloat loopTimeInterval;

/**
 *  是否自动滚动，df = yes
 */
@property (assign,nonatomic) BOOL loopScroll;

/**
 *  是否隐藏小点，df = no 
 */
@property (assign,nonatomic) BOOL loopHidePageControl;
/**
 *  小点的默认颜色
 */
@property (strong,nonatomic) UIColor *pageControlIndicatorTintColor;
/**
 *  当前小点的颜色
 */
@property (strong,nonatomic) UIColor *pageControlCurrentIndicatorTintColor;


/**
 *  (deprecated, use `ls_loopViewWithFrame:imagesArray:titleArray:selectedBlock`)创建一个view，包括了images (must)，title(可以没有)，pagesCtrol(有title时居右，无title时居中显示),可以自动滚动,可设定滚动的间隔时间，
 *
 *  @param frame  view 的 frame
 *  @param delegate LoopViewDelegate
 *  @param images imagesName array
 *  @param titles title array
 *
 *  @return LoopView
 */
+ (instancetype)loopViewWithFrame:(CGRect)frame delegate:(id<LSLoopViewDelegate>)delegate imagesArray:(NSMutableArray *)images titleArray:(NSMutableArray *)titles __deprecated_msg("Use `ls_loopViewWithFrame:imagesArray:titleArray:selectedBlock`");
/**
 *  (deprecated, use `ls_loopViewWithFrame:imagesURLArray:titleArray:placeholder:selectedBlock`)
 *
 *  @param frame     <#frame description#>
 *  @param delegate  <#delegate description#>
 *  @param imageURLs <#imageURLs description#>
 *  @param titles    <#titles description#>
 *  @param imgName   <#imgName description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)loopViewWithFrame:(CGRect)frame delegate:(id<LSLoopViewDelegate>)delegate imagesURLArray:(NSMutableArray *)imageURLs titleArray:(NSMutableArray *)titles placeholder:(NSString *)imgName __deprecated_msg("Use `ls_loopViewWithFrame:imagesURLArray:titleArray:placeholder:selectedBlock`");



// ==== local image

+ (instancetype)ls_loopViewWithFrame:(CGRect)frame imagesArray:(NSMutableArray *)images titleArray:(NSMutableArray *)titles selectedBlock:(didSelectedIndex)block;

- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSMutableArray *)images titleArray:(NSMutableArray *)titles selectedBlock:(didSelectedIndex)block;



// ==== images url
+ (instancetype)ls_loopViewWithFrame:(CGRect)frame imagesURLArray:(NSMutableArray *)imageURLs titleArray:(NSMutableArray *)titles placeholder:(NSString *)imgName selectedBlock:(didSelectedIndex)block;

- (instancetype)initWithFrame:(CGRect)frame imagesURLArray:(NSMutableArray *)imageURLs titleArray:(NSMutableArray *)titles placeholder:(NSString *)imgName selectedBlock:(didSelectedIndex)block;



@end




@interface LSLoopViewCell : UICollectionViewCell

@property (strong,nonatomic) UIImageView *imageView;

@end





