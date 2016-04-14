//
//  AlertView.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/22.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/// 指定时间后自动消失的提示窗
+ (void)showMessage:(NSString*)message time:(float)time
{
    dispatch_main(^{
    CGSize size = [self getSizeForText:message font:[UIFont systemFontOfSize:16] withConstrainedSize:CGSizeMake(DEVICE_WIDTH *.6, 200)];

    if(size.width < 50) {
        size.width = 50;
    }
    if(size.height < 40) {
        size.height = 40;
    }

    UILabel *label = [[UILabel alloc] init];
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor clearColor];

    label = [self LabelWithFrame:CGRectMake(0, 0, size.width + 20, size.height + 10) withText:message withTextColor:[UIColor whiteColor] withFont:16 withTextAlignment:NSTextAlignmentCenter withBackColor:[UIColor blackColor]];
    [label.layer setCornerRadius:10.0];
    label.clipsToBounds = YES;
    label.alpha = 0.8;
    CGPoint center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y-50);
    [label setCenter:center];

    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
    //        [UIView animateWithDuration:0.3 animations:^{
    //            label.alpha = 0.8;
    //        }];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
        [NSThread sleepForTimeInterval:time];
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.0 animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                [bgView removeFromSuperview];
                [label removeFromSuperview];
            }];
        });
    });
});
    
}

/// 指定时间后自动消失的提示窗 并指定显示的中心点
+ (void)showMessage:(NSString*)message time:(float)time center:(CGPoint)point
{
    CGSize size = [self getSizeForText:message font:[UIFont systemFontOfSize:16] withConstrainedSize:CGSizeMake(280, 200)];

    if(size.width < 50) {
        size.width = 50;
    }
    if(size.height < 40) {
        size.height = 40;
    }

    UILabel *label = [self LabelWithFrame:CGRectMake(0, 0, size.width + 20, size.height + 10) withText:message withTextColor:[UIColor whiteColor] withFont:16 withTextAlignment:NSTextAlignmentCenter withBackColor:[UIColor blackColor]];
    [label.layer setCornerRadius:10.0];
    label.clipsToBounds = YES;
    //    [label setCornerRadius:size.width/10.0 andBorderWidth:0 andBorderColor:nil];
    //    [label.layer setBorderWidth:0];

    label.alpha = 0;
    [label setCenter:point];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
    [UIView animateWithDuration:0.3 animations:^{
        label.alpha = 0.8;
    }];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
        [NSThread sleepForTimeInterval:time];
        
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.3 animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        });
    });
}

// 获取文字所占长宽
+ (CGSize)getSizeForText:(NSString *)text font:(UIFont *)font withConstrainedSize:(CGSize)size
{
    CGSize new;
    if(kIOS_7) {
        
        NSDictionary *attribute = @{NSFontAttributeName: font};
        new = [text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    
    return new;
}

// label
+ (UILabel *)LabelWithFrame:(CGRect)rect withText:(NSString *)text withTextColor:(UIColor *)textColor withFont:(int)fontSize withTextAlignment:(NSTextAlignment)alignment withBackColor:(UIColor *)backColor
{
    UILabel *label        = [[UILabel alloc] initWithFrame:rect];
    label.text            = text;
    label.numberOfLines   = 0;
    label.textColor       = textColor;
    label.font            = [UIFont systemFontOfSize:fontSize];
    label.textAlignment   = alignment;
    label.backgroundColor = backColor;
    return label;
}

- (void)removeFromSuperview {
    
    [super removeFromSuperview];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
