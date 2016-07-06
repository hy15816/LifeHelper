//
//  LSScrollView.m
//  LifeHelper
//
//  Created by Lost_souls on 16/6/27.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "LSScrollView.h"

@implementation LSScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (self.contentOffset.y <0 || self.contentOffset.y > self.contentSize.height) {
        return self.superview;
    }
    
    return [super hitTest:point withEvent:event];
}

@end
