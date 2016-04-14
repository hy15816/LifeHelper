//
//  NotFoundView.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/31.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "NotFoundView.h"

@interface NotFoundView ()

@property (strong,nonatomic) void (^clickActionBlock)();
@end

@implementation NotFoundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)createViewWithFrame:(CGRect)frame msg:(NSString *)message block:(void (^)())block {
    
    if (block) {
        self.clickActionBlock = block;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 3;
    button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [button setTitle:message forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, frame.size.width *.6, 40);
    button.center = view.center;
    [button addTarget:self action:@selector(buttonClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    
    [self addSubview:view];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)buttonClickAction {
    
    self.clickActionBlock();
    
}

- (void)removeFromSuperview {
    
    [super removeFromSuperview];
    
    [self removeFromSuperview];
}

@end
