//
//  ChartView.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/29.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartView : UIView

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic) float progress;//0~1之间的数
@property (nonatomic) float progressWidth;

- (instancetype)initWithFrame:(CGRect)frame progress:(BOOL)progress;
- (void)setProgress:(float)progress animated:(BOOL)animated;


@end
