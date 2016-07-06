//
//  LSCustomSlider.m
//  anxindian
//
//  Created by Lost_souls on 16/5/19.
//  Copyright © 2016年 anerfa. All rights reserved.
//

#define kAnimations     .1f

#import "LSCustomSlider.h"

@interface LSCustomSlider ()
{
    BOOL _isHandleHidden;
}
@property (strong,nonatomic) UIView *foregroundView;
@property (strong,nonatomic) UILabel *label;

@property (strong,nonatomic) UIImageView *bgImageView; // 底层背景图片

@property (strong,nonatomic) UIView *centerView;// 中间层
@property (strong,nonatomic) UIImageView *centerImgv1;
@property (strong,nonatomic) UIImageView *centerImgv2;

@property (strong,nonatomic) UIImageView *thumbImageView;

@property (strong,nonatomic) NSTimer *timer;

@end

@implementation LSCustomSlider


-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initSlider];
    }
    
    return self;

}

- (void)initSlider {
    
    
    _isHandleHidden = NO;
    self.foregroundView = [[UIView alloc] init];
    
    self.thumbView = [[UIView alloc] init];
    self.thumbView.layer.cornerRadius = self.frame.size.height/2.f ;//viewCornerRadius;
    self.thumbView.layer.masksToBounds = YES;
    
    self.thumbImageView = [[UIImageView alloc] init];
    [self.thumbView addSubview:self.thumbImageView];
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.bgImageView];
    
    // 2倍self的宽度
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(-self.frame.size.width*1.2, 0, self.frame.size.width*2, self.frame.size.height)];
    
    UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*1.75, self.frame.size.height)];
    imageV1.backgroundColor = kCOLORRGB(181, 181, 181, 1);
    imageV1.layer.cornerRadius = self.frame.size.height/2.f;
    imageV1.layer.masksToBounds = YES;
    self.centerImgv1 = imageV1;
    
    UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*1.6, self.frame.size.height)];
    imageV2.backgroundColor =  kCOLORRGB(228, 228, 228, 1);
    imageV2.layer.cornerRadius = self.frame.size.height/2.f;
    imageV2.layer.masksToBounds = YES;
    self.centerImgv2 = imageV2;
    
    [self.centerView addSubview:imageV1];
    [self.centerView addSubview:imageV2];
    
    [self addSubview:self.centerView];
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height/2, 0, self.frame.size.width-self.frame.size.height/2, self.frame.size.height)];
    
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont fontWithName:@"Helvetica" size:24];
    
    [self addSubview:self.label];
    [self addSubview:self.foregroundView];
    [self addSubview:self.thumbView];
    
    self.layer.masksToBounds = YES;
    
    // 设置默认值
    [self setValue:0.0 animation:NO completion:nil];
    
    [self startScrollTimer];
}

- (void)startScrollTimer {
    
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(viewWithAutoScroll) userInfo:nil repeats:YES];
    self.timer = time;
    [[NSRunLoop mainRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
}

- (void)viewWithAutoScroll {
    
    NNLog(@"Scroll");
    if (self.centerView.frame.origin.x > -self.frame.size.width *.60f-20) {
        
        [UIView animateWithDuration:.5 animations:^{
            //
            self.centerView.frame = CGRectMake(self.centerView.frame.origin.x +1, 0, self.frame.size.width*2, self.frame.size.height);
            self.centerView.alpha = 0.0;
        }];
        if (self.centerView.frame.origin.x > -self.frame.size.width *.60f) {
            [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.centerView.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.centerView.frame = CGRectMake(-self.frame.size.width*1.65, 0, self.frame.size.width*2, self.frame.size.height);
                self.centerView.alpha = 1.0;
            }];
        }
        
    }else{
        [UIView animateWithDuration:.2 animations:^{
            //
            self.centerView.frame = CGRectMake(self.centerView.frame.origin.x +1, 0, self.frame.size.width*2, self.frame.size.height);
        }];
    }
    
}

#pragma mark - Set Value

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.label.font = textFont;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.label.textColor = textColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    
    self.bgImageView.image = backgroundImage;
}

- (void)setThumbImage:(UIImage *)thumbImage {
    _thumbImage = thumbImage;
    self.thumbImageView.frame = self.thumbView.bounds;
    self.thumbImageView.image = thumbImage;
}

-(void)setForegroundColor:(UIColor *)foregroundColor {
    _foregroundColor = foregroundColor;
    self.foregroundView.backgroundColor = foregroundColor;
}

- (void)setShowTextComplete:(BOOL)showTextComplete {
    _showTextComplete = showTextComplete;
    
    if (showTextComplete) {
        [self bringSubviewToFront:self.label];
        [self bringSubviewToFront:self.thumbView];
    }
}


- (void)setCenterViewImage1:(UIImage *)centerViewImage1{
    
    _centerViewImage1 = centerViewImage1;
    self.centerImgv1.image = centerViewImage1;
    
}

- (void)setCenterViewImage2:(UIImage *)centerViewImage2{
    
    _centerViewImage2 = centerViewImage2;
    self.centerImgv2.image = centerViewImage2;
}


- (void)setValue:(float)value animation:(bool)animate completion:(void (^)(BOOL))completion{
    
    NSAssert((value >= 0.0)&&(value <= 1.0), @"Value must be between 0 and 1");
    
    if (value < 0) {
        value = 0;
    }
    
    if (value > 1) {
        value = 1;
    }
    
    CGPoint point = CGPointMake(value * self.frame.size.width, 0);
    
    if(animate) {
        __weak __typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:kAnimations animations:^ {
            [weakSelf changeStarForegroundViewWithPoint:point];
            
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    } else {
        [self changeStarForegroundViewWithPoint:point];
    }
}


-(void)setBackgroundColor:(UIColor *)bgColor foreground:(UIColor *)fColor handle:(UIColor *)hCol border:(UIColor *)brdrCol{
    
    self.backgroundColor = bgColor;
    self.foregroundView.backgroundColor = fColor;
    self.thumbView.backgroundColor = hCol;
    [self.layer setBorderColor:brdrCol.CGColor];
    
}

#pragma mark - Touch Events

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (!(point.x < 0) && !(point.x > self.frame.size.width)) {
        [self changeStarForegroundViewWithPoint:point];
    }
    
    if ((point.x >= 0) && point.x <= self.frame.size.width-self.frame.size.height) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slider:valueChanged:)]) {
            [self.delegate slider:self valueChanged:self.value];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:kAnimations animations:^ {
        [weakSelf changeStarForegroundViewWithPoint:point];
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sliderValueChangeEnd:)]) {
            [self.delegate sliderValueChangeEnd:self];
        }
        
        if (self.value <=0.95) {
            [UIView animateWithDuration:.25 animations:^{
                //
                [self changeStarForegroundViewWithPoint:CGPointMake(0, 0)];
            }];
        }
        
    }];
}

#pragma mark - Change Slider Foreground With Point

- (void)changeStarForegroundViewWithPoint:(CGPoint)point {
    CGPoint p = point;
    
    if (p.x < 0) {
        p.x = 0;
    }
    
    if (p.x > self.frame.size.width - self.frame.size.height/2) {
        p.x = self.frame.size.width - self.frame.size.height/2;
    }
    
    self.value = p.x / (self.frame.size.width - self.frame.size.height/2);
    self.foregroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
    if (!_isHandleHidden) {
        
        if (self.foregroundView.frame.size.width <= self.frame.size.height/2) {
            
            self.thumbView.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
            [self.delegate slider:self valueChanged:self.value];
        
        }else if (self.foregroundView.frame.size.width >= self.frame.size.width - self.frame.size.height/2) {
            
            self.thumbView.frame = CGRectMake(self.foregroundView.frame.size.width-self.frame.size.height/2, 0, self.frame.size.height, self.frame.size.height);
            [self.delegate slider:self valueChanged:self.value];
        
        }else{
            
            self.thumbView.frame = CGRectMake(self.foregroundView.frame.size.width-self.frame.size.height/2, 0, self.frame.size.height, self.frame.size.height);
        }
        
    }
}


- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    if (!newSuperview) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
