//
//  NSString+TextHeight.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/31.
//  Copyright © 2015年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (TextHeight)

/**
 *  获取指定宽度的文字所占的高度
 *
 *  @param text  文本
 *  @param font  文本字体
 *  @param width 宽度
 *
 *  @return 高度
 */
- (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

@end
