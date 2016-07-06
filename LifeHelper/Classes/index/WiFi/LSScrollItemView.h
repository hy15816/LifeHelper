//
//  LSScrollItemView.h
//  LifeHelper
//
//  Created by Lost_souls on 16/6/21.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSScrollItemView;
typedef void(^didSelectBtnBlock)(LSScrollItemView *itemView,NSInteger index);

@interface LSScrollItemView : UIView
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles block:(didSelectBtnBlock)block;
@end



@interface LSItemCell : UICollectionViewCell

/**
 *  标题
 */
@property (strong,nonatomic) UILabel *label;
/**
 *  分割线
 */
@property (strong,nonatomic) UILabel *splitLine;

@end