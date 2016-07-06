//
//  NSString+TextHeight.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/31.
//  Copyright © 2015年 yim. All rights reserved.
//

#import "NSString+TextHeight.h"

@implementation NSString (TextHeight)

- (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    
    NSDictionary * attributes = @{NSFontAttributeName : font};
    
    CGSize contentSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics)
                                         attributes:attributes
                                            context:nil].size;
    
    return contentSize.height ;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    
    
    NSDictionary * attributes = @{NSFontAttributeName : font};
    
    CGSize contentSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil].size;
    
    return contentSize;
    
}
@end
