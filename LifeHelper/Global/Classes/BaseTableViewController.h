//
//  BaseTableViewController.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestObj.h"

@interface BaseTableViewController : UITableViewController

/**
 *  是否显示tipsLabel
 */
@property (assign,nonatomic) BOOL canShowTipsLabel;

/**
 *  设置tipsLabel的text(显示则要设置 canShowTipsLabel = YES) <@see canShowTipsLabel>
 *
 *  @param text      text
 *  @param animation 是否动画效果
 */
- (void)setTipsText:(NSString *)text animation:(BOOL)animation;

/**
 *  返回顶部
 */
- (void)scrollerToTopAction;

@end
