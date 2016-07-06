//
//  ChartGrideView.m
//  LifeHelper
//
//  Created by Lost_souls on 16/6/20.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#define kGradeMarginTop     10
#define kGradeMarginLeft    30

#define kLabelHeight    15
#define kLabelWidth     30

//#define kVerticalLineMarginLeft     40      //竖线间距(左右)
//#define kHorizontalLineMarginTop    20      //横线间距(上下)

#define  UULabelHeight 10.f
#define UUTagLabelwidth     80


#import "ChartGrideView.h"
#import "LSChartView.h"

@interface ChartGrideView ()

@property (assign, nonatomic) id<ChartGrideViewDataSource> dataSource;
@property (assign, nonatomic) CGFloat lineMarginVertical;   // 底线左右间距
//@property (assign, nonatomic) CGFloat lineMarginHorizontal; // 底线上下间距

@end

@implementation ChartGrideView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<ChartGrideViewDataSource>)dataSource {
    if (dataSource) {
        self.dataSource = dataSource;
    }
    
    return [self initWithFrame:frame];
}

- (void)showInView:(UIView *)view points:(NSArray *)points
{
    [self setupChartView:points];
    [view addSubview:self];
}

- (void)reloadData:(NSArray *)points{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self addBackgroundLine:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self setupChartView:points];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        
        [self addBackgroundLine:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    return self;
}

#pragma mark - 网格
- (void)addBackgroundLine:(CGRect)frame{
    
    NSArray *vertitles = [self.dataSource chartViewVerticalTitles:self];
    NSArray *hortitles = [self.dataSource chartViewHorizontalTitles:self];
    UIColor *color = [self isLightColor:self.backgroundColor]?[UIColor blackColor]:[UIColor whiteColor];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(backgroundLineColor)]) {
        color = [self.dataSource backgroundLineColor];
    }
    
    CGFloat lineW = 0.5f;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(backgroundLineWidth)]) {
        lineW = [self.dataSource backgroundLineWidth];
    }
    
    LSGrideView *chview = [[LSGrideView alloc] initWithFrame:frame xList:vertitles yList:hortitles color:color width:lineW];
    [self addSubview:chview];
}


- (void)setupChartView:(NSArray *)points {
    
    // label
    [self drawTextLabel:CGRectMake(kGradeMarginLeft, kGradeMarginTop, self.frame.size.width - kGradeMarginLeft, self.frame.size.height - kGradeMarginTop - kGradeMarginLeft)];
    
    
    [self drawPointWith:points];
    
}

- (void)drawPointWith:(NSArray *)points {
    
    [self strokeChart:@[points]];
    
}

#pragma mark - 标题 label
- (void)drawTextLabel:(CGRect)rect{
    
    NSArray *vertitles = [self.dataSource chartViewVerticalTitles:self];
    NSInteger verticalLineCount = [vertitles count];
    
    self.lineMarginVertical = (rect.size.width- kGradeMarginLeft)/verticalLineCount;
    
    for (int i=0; i< verticalLineCount; i++) {
        
        UILabel *label = [self createTextLabel:vertitles[i] center:CGPointMake(i * (rect.size.width)/ verticalLineCount+kGradeMarginLeft, rect.size.height + kGradeMarginLeft)];
        [self addSubview:label];
        
    }
    
    
    // 横线 （从上往下，第一根横线不要了）
    NSArray *hortitles = [self.dataSource chartViewHorizontalTitles:self];
    int horizontalLineCount = (int)[hortitles count];
    for (int i=0; i< horizontalLineCount; i++) {
        
        UILabel *label = [self createTextLabel:hortitles[horizontalLineCount-i-1] center:CGPointMake(10, i * (rect.size.height) / horizontalLineCount + kGradeMarginTop)];
        [self addSubview:label];
    }
    
}

- (UIBezierPath *)drawStraightLine:(CGPoint)startp endPoint:(CGPoint)endPoint {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startp];
    [path addLineToPoint:endPoint];
    CGFloat lineW = 0.5f;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(backgroundLineWidth)]) {
        lineW = [self.dataSource backgroundLineWidth];
    }
    path.lineWidth = lineW;
    UIColor *color = [self isLightColor:self.backgroundColor]?[UIColor blackColor]:[UIColor whiteColor];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(backgroundLineColor)]) {
        color = [self.dataSource backgroundLineColor];
    }
    UIColor *pathColor =  color;
    [pathColor set];
    
    return path;
    
}

- (UILabel *)createTextLabel:(NSString *)title center:(CGPoint)center {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLabelWidth, kLabelHeight)];
    label.text = title ;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [self isLightColor:self.backgroundColor]?[UIColor blackColor]:[UIColor whiteColor];
    if (self.textColor) {
        label.textColor = self.textColor;
    }
    label.center = center ;
    [self addSubview:label];
    
    return label;
}


#pragma mark - 折线 & 小圆点
-(void)strokeChart:(NSArray *)_yValues;
{
    
    CGFloat radius = 3;
    if (self.chartPointRadius) {
        radius = self.chartPointRadius;
    }
    for (int i=0; i<_yValues.count; i++) {
        NSArray *childAry = _yValues[i];
        if (childAry.count==0) {
            return;
        }
        //获取最大最小位置
        CGFloat max = [childAry[0] floatValue];
        CGFloat min = [childAry[0] floatValue];
        NSInteger max_i = 0;
        NSInteger min_i = 0;
        
        for (int j=0; j<childAry.count; j++){
            CGFloat num = [childAry[j] floatValue];
            if (max<=num){
                max = num;
                max_i = j;
            }
            if (min>=num){
                min = num;
                min_i = j;
            }
        }
        
//        NNLog(@"min:%ld---max:%ld",(long)min_i,(long)max_i);
        
        //画折线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = self.chartLineWidth?self.chartLineWidth:2.0f;
        _chartLine.strokeEnd   = 0.0;
        [self.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        CGFloat xPosition = (kGradeMarginLeft + self.lineMarginVertical/2.0 + radius);
        CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
        
        NSArray *hortitles = [self.dataSource chartViewHorizontalTitles:self];
        CGFloat _yValueMin = 0;
        CGFloat _yValueMax = [[hortitles lastObject] floatValue];
        float grade = ((float)firstValue-_yValueMin) / ((float)_yValueMax-_yValueMin);
        
        // 显示每个点的值
        BOOL isShowMaxAndMinPoint = NO;
        if (childAry) {
            if ([childAry[i] intValue]>0) {
                isShowMaxAndMinPoint = (max_i==0 || min_i==0)?YES:NO;
            }else{
                isShowMaxAndMinPoint = NO;
            }
        }
        
        [self addPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)
                 index:i
                isShow:isShowMaxAndMinPoint
                 value:firstValue];
        
        [progressline moveToPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)];
        [progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        for (NSString * valueString in childAry) {
            
            float grade =([valueString floatValue]-_yValueMin) / ((float)_yValueMax-_yValueMin);
            if (index != 0) {
                
                CGPoint point = CGPointMake(xPosition+index*(self.lineMarginVertical+radius), chartCavanHeight - grade * chartCavanHeight+UULabelHeight);
                [progressline addLineToPoint:point];
                
                BOOL isShowMaxAndMinPoint = NO;
                if (childAry) {
                    if ([childAry[i] intValue]>0) {
                        isShowMaxAndMinPoint = (max_i==index || min_i==index)?YES:NO;
                    }else{
                        isShowMaxAndMinPoint = NO;
                    }
                }
                [progressline moveToPoint:point];
                [self addPoint:point
                         index:i
                        isShow:isShowMaxAndMinPoint
                         value:[valueString floatValue]];
            }
            index += 1;
        }
        
        _chartLine.path = progressline.CGPath;
        _chartLine.strokeColor = self.chartLineColor?self.chartLineColor.CGColor: [UIColor greenColor].CGColor; // fix
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = childAry.count*0.4;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        _chartLine.strokeEnd = 1.0;
    }
}

// isShowMaxAndMin: 显示最大最小值
- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isShowMaxAndMin value:(CGFloat)value
{
    // 小圆点
    CGFloat radius = 3;
    if (self.chartPointRadius) {
        radius = self.chartPointRadius;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 5, radius *2, radius *2)];
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = radius;
    view.layer.borderWidth = 2;
    view.layer.borderColor = self.chartPointColor? self.chartPointColor.CGColor: [UIColor greenColor].CGColor; //fix
    
    if (self.isHollow) {
        view.backgroundColor = [UIColor clearColor];
    }else{
        view.backgroundColor = self.chartPointColor? self.chartPointColor: [UIColor greenColor];
    }
    
    if (isShowMaxAndMin && self.isShowMaxAndMin) {
        
        view.backgroundColor = [UIColor whiteColor]; //fix
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-UUTagLabelwidth/2.0, point.y-UULabelHeight*2, UUTagLabelwidth, UULabelHeight)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [self isLightColor:self.backgroundColor]?[UIColor blackColor]:[UIColor whiteColor];
        if (self.textColor) {
            label.textColor = self.textColor;
        }
        if (self.textFont) {
            label.font = self.textFont;
        }
        label.text = [NSString stringWithFormat:@"%d",(int)value];
        [self addSubview:label];
    }
    
    [self addSubview:view];
}

#pragma mark - 判断颜色是否是亮色
//判断颜色是不是亮色
-(BOOL) isLightColor:(UIColor*)clr {
    CGFloat components[3];
    [self getRGBComponents:components forColor:clr];
//    NSLog(@"%f %f %f", components[0], components[1], components[2]);
    
    CGFloat num = components[0] + components[1] + components[2];
    if(num < 382)
        return NO;
    else
        return YES;
}

//获取RGB值
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 bitmapInfo);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component];
    }
}

@end




