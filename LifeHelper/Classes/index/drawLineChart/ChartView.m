//
//  ChartView.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/29.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#define kLabelHeight    15
#define kLabelWidth     30

#define kGradeMarginTop     10
#define kGradeMarginLeft    30

#define kVerticalLineMarginLeft     20      //竖线间距(左右)
#define kHorizontalLineMarginTop    50      //横线间距(上下)

#define kDegressToRadians(degress) ((M_PI * degress) / 180)

#import "ChartView.h"

/**
 *  直线类型
 *
 *  @param StraightLineTypeVertical     垂直
 *  @param ChartLineTypeHorizontal      水平
 */

typedef NS_ENUM(NSInteger,StraightLineType) {
    StraightLineTypeVertical = 0,
    StraightLineTypeHorizontal
};

@interface PointXY : NSObject

@property (assign,nonatomic) CGFloat x;
@property (assign,nonatomic) CGFloat y;

@end

@implementation PointXY

- (void)abc {
    
}

@end

#pragma mark - -----------------

@interface ChartView ()
{
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
}

@property (assign,nonatomic) BOOL isShowProgress;
@end
@implementation ChartView

- (void)drawRect:(CGRect)rect {
    
//    [super drawRect:rect];
    if (!self.isShowProgress) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self drawTriangleWith:CGPointMake(85, 320) point2:CGPointMake(35, 370) point3:CGPointMake(135, 370)];
        [self drawSquareWithFrame:CGRectMake(180, 15, 100, 120) corners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
        [self drawSquareWithFrame:CGRectMake(35, 110, 80, 100) lineCapStyle:kCGLineCapRound lineJoinStyle:kCGLineJoinBevel];
        [self drawSquareWithFrame:CGRectMake(35, 220, 80, 80) lineCapStyle:kCGLineCapRound lineJoinStyle:kCGLineJoinBevel];
        [self drawGrade:CGRectMake(kGradeMarginLeft, kGradeMarginTop, self.frame.size.width - kGradeMarginLeft, self.frame.size.height - kGradeMarginTop - kGradeMarginLeft) radius:1];
        
        NSArray *array = @[@[@"40",@"40"],@[@"35",@"80"],@[@"65",@"100"],@[@"135",@"100"],@[@"165",@"60"],@[@"145",@"30"],@[@"85",@"0"]];
        [self drawCustomWithPoints:array ];
        
        // 顺时针画弧  从0°角度开始 画135°
        [self drawARCPath:CGPointMake(200, 200) radius:50 startAngle:0 endAngle:kDegressToRadians(135) clockwise:NO];
        // 贝塞尔二次曲线
        [self drawCurveLine:CGPointMake(180, 300) endPoint:CGPointMake(self.frame.size.width-20, 300) controlPoint:CGPointMake(260, 250)];
        // 贝塞尔三次曲线
        [self drawCurve2Line:CGPointMake(160,350) endPoint:CGPointMake(self.frame.size.width-20, 350) controlPoint1:CGPointMake(180, 300) controlPoint2:CGPointMake(220, 400)];
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame progress:(BOOL)progress {
    
    self.isShowProgress = progress;
    self = [super initWithFrame:frame];
    if (self) {
        if (progress) {
            [self initProgress];
        }
    }
    
    return self;
}

/**
 *  画三角形
 *
 *  @param point  点1
 *  @param point2 点2
 *  @param point3 点3
 */
- (void)drawTriangleWith:(CGPoint)point point2:(CGPoint)point2 point3:(CGPoint)point3 {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    
    // 设置闭合线,
    [path closePath];
    // 也可以通过[path addLineToPoint:point(原点)]; 实现
    
    path.lineWidth = 1.0f;
    
    //  设置填充颜色<先填充在设置画笔颜色，，不然画笔颜色会被覆盖>
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *penColor = [UIColor redColor];
    [penColor set];
    
    // 连线
    [path stroke];
    
}

/**
 *  画矩形(正方形)
 *
 *  @param frame
 *
 *  @param frame         CGRectMake(x,y,w,h)
 *  @param lineCapStyle  @see CGLineCap     设置线条拐角帽的样式的
 *  @param lineJoinStyle @see CGLineJoin    设置两条线连接点的样式
 */
- (void)drawSquareWithFrame:(CGRect)frame lineCapStyle:(CGLineCap)lineCapStyle lineJoinStyle:(CGLineJoin)lineJoinStyle{
    // 创建贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    
    path.lineWidth = 1.5f;
    /**
     *  kCGLineCapButt,     //默认
        kCGLineCapRound,    //轻微圆角
        kCGLineCapSquare    //正方形
     */
    path.lineCapStyle = lineCapStyle;    //设置线条拐角帽的样式的
    /**
     *  kCGLineJoinMiter,   //斜接
        kCGLineJoinRound,   //圆滑衔接
        kCGLineJoinBevel    //斜角连接
     */
    path.lineJoinStyle = lineJoinStyle;  //设置两条线连接点的样式，
    
    //  设置填充颜色<先填充在设置画笔颜色，，不然画笔颜色会被覆盖>
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *penColor = [UIColor redColor];
    [penColor set];
    
    // 根据设置的点连线
    [path stroke];
}

/**
 *  画圆，传正方形的参数就可以了
 *
 *  @param frame CGRectMake(x,y,w,h)
 */
- (void)drawCycle:(CGRect)frame {
    
    // 1.方形 + 圆角类型
    UIBezierPath *pathRound = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:frame.size.width * 0.5];
    UIColor *roundColor = [UIColor greenColor];
    [roundColor set];
    [pathRound stroke];
    
    // 2.正方形时画圆，非正方形画椭圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:frame];
    UIColor *pathColor = [UIColor greenColor];
    [pathColor set];
    [path stroke];
    
    // 3.
    
}

/**
 *  画一个不正规方形（其中有一个或多个角是圆角）
 *
 *  @param frame   frame
 *  @param corners @see UIRectCorner    指定哪个角需要变圆角
 *  @param size     指定水平和垂直方向的半径的大小
 */
- (void)drawSquareWithFrame:(CGRect)frame corners:(UIRectCorner)corners cornerRadii:(CGSize)size
{
    UIBezierPath *pathRound = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corners cornerRadii:size];
    
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [pathRound fill];
    
    UIColor *roundColor = [UIColor redColor];
    [roundColor set];
    [pathRound stroke];
}
/**
 *  画圆
 *
 *  @param center     圆心
 *  @param radius     半径
 *  @param startAngle 圆弧起点弧度
 *  @param endAngle   圆弧终点弧度
 *  @param clockwise  顺时针或逆时针画圆弧 YES:逆时针
 *  Discussion: startAngle 和 endAngle使用的弧度，而不是角度，因此要将我们要的角度转换成弧度，
 */
- (void)drawARCPath:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;{
    
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    arcPath.lineWidth = 1.5;
    arcPath.lineCapStyle = kCGLineCapRound;
    arcPath.lineJoinStyle = kCGLineJoinRound;
    
    UIColor *roundColor = [UIColor redColor];
    [roundColor set];
    [arcPath stroke];
}
/**
 *  二次贝塞尔曲线
 *
 *  @param endPoint     终端点
 *  @param controlPoint 控制点(二次贝塞尔曲线只有一个控制点)
 */
- (void)drawCurveLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //设置起点
    [path moveToPoint:startPoint];
    
    //添加二次曲线
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    path.lineWidth = 2.5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    UIColor *roundColor = [UIColor purpleColor];
    [roundColor set];
    [path stroke];
    
}

/**
 *  三次贝塞尔曲线
 *
 *  @param endPoint      终端点
 *  @param controlPoint1 控制点1
 *  @param controlPoint2 控制点2
 */
- (void)drawCurve2Line:(CGPoint)startPoint endPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2 {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //设置起点
    [path moveToPoint:startPoint];
    
    //添加三次曲线
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    path.lineWidth = 2.5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    UIColor *roundColor = [UIColor brownColor];
    [roundColor set];
    [path stroke];
    
}

/**
 *  不规则的闭环图形
 *
 *  @param points 点的数组
 */
- (void)drawCustomWithPoints:(NSArray<NSArray *> *)points {

    // 最外环 1层
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSArray *point1 = points[0];
    [path moveToPoint:CGPointMake([point1[0] floatValue], [point1[1] floatValue])];
    
    for (NSArray *pxy in points) {
        CGPoint point = CGPointMake([pxy[0] floatValue], [pxy[1] floatValue]);
        [path addLineToPoint:point];
        NSLog(@"{%.f,%.f}",[pxy[0] floatValue], [pxy[1] floatValue]);
    }
    
    [path closePath];
    
    // 设置画笔颜色
    UIColor *penColor = [UIColor blueColor];
    [penColor set];
    
    // 根据设置的点连线
    [path stroke];
    
}

/**
 *  画网格 + 网格 + 标识
 *
 ...+ + + + + + + + + +
 20 + + + + + + + + + +
 10 + + + + + + + + + +
  0 + + + + + + + + + +
    0 1 2 3 ...
 *  @param rect     位置大小
 *  @param radius   圆角值 <当值为rect.width * 0.5 时，效果画圆>
 */
- (void)drawGrade:(CGRect)rect radius:(CGFloat)radius {
    
    // 外框
    UIBezierPath *pathRound = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    UIColor *roundColor = [UIColor greenColor];
    [roundColor set];
    [pathRound stroke];
    
    // 竖线
    NSInteger verticalLineCount = rect.size.width / kVerticalLineMarginLeft;
    for (int i=0; i< verticalLineCount; i++) {
        CGPoint pointstart = CGPointMake(i * (rect.size.width)/ verticalLineCount+ kGradeMarginLeft , kGradeMarginTop);
        CGPoint pointend = CGPointMake(i * (rect.size.width)/ verticalLineCount+kGradeMarginLeft, rect.size.height + kGradeMarginTop );
        UIBezierPath *verticalLine = [self drawStraightLine:pointstart endPoint:pointend];
        [verticalLine stroke];
        
        UILabel *label = [self createTextLabel:[NSString stringWithFormat:@"%d0",i] center:CGPointMake(i * (rect.size.width)/ verticalLineCount+kGradeMarginLeft, rect.size.height + kGradeMarginLeft)];
        [self addSubview:label];
        
    }
    
    // 横线
    int horizontalLineCount = rect.size.height / kHorizontalLineMarginTop;
    for (int i=0; i< horizontalLineCount; i++) {
        
        NSString *title = [NSString stringWithFormat:@"%d0",horizontalLineCount-i-1];
        UILabel *label = [self createTextLabel:title center:CGPointMake(10, i * (rect.size.height) / horizontalLineCount + kGradeMarginTop)];
        [self addSubview:label];
        
        CGPoint pointstart = CGPointMake(kGradeMarginLeft, i * (rect.size.height) / horizontalLineCount + kGradeMarginTop);
        CGPoint pointend = CGPointMake(rect.size.width + kGradeMarginLeft , i * (rect.size.height) / horizontalLineCount + kGradeMarginTop);
        UIBezierPath *horizontalLine = [self drawStraightLine:pointstart endPoint:pointend];
        [horizontalLine stroke];
    }
    
}

- (UIBezierPath *)drawStraightLine:(CGPoint)startp endPoint:(CGPoint)endPoint {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startp];
    [path addLineToPoint:endPoint];
    path.lineWidth = .5f;
    UIColor *pathColor = [UIColor greenColor];
    [pathColor set];
    
    return path;
    
}

- (UILabel *)createTextLabel:(NSString *)title center:(CGPoint)center {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLabelWidth, kLabelHeight)];
    label.text = title ;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.center = center ;
    [self addSubview:label];
    
    return label;
}


#pragma mark - 画一个进度条

- (void)initProgress {
    
    self.backgroundColor = [UIColor whiteColor];
    _trackLayer = [CAShapeLayer new];
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.frame = self.bounds;
    
    _progressLayer = [CAShapeLayer new];
    [self.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = nil;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.frame = self.bounds;
    
    //默认5
    self.progressWidth = 5;
    
}

- (void)setTrackPath {
    
    _trackPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];;
    _trackLayer.path = _trackPath.CGPath;
    
}

- (void)setProgressPath {
    
    _progressPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * _progress - M_PI_2 clockwise:YES];
    _progressLayer.path = _progressPath.CGPath;
}

- (void)setProgressWidth:(float)progressWidth {
    _progressWidth = progressWidth;
    _trackLayer.lineWidth = progressWidth;
    _progressLayer.lineWidth = progressWidth;
    
    [self setTrackPath];
    [self setProgressPath];
}

- (void)setTrackColor:(UIColor *)trackColor {
    
    _trackColor = trackColor;
    _trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor {
    
    _progressColor = progressColor;
    _progressLayer.strokeColor = progressColor.CGColor;
    
}

- (void)setProgress:(float)progress {
    
    _progress = progress;
    [self setProgressPath];
}


- (void)setProgress:(float)progress animated:(BOOL)animated {
    
    _progress = progress ;
    [self setProgressPath];
    
}



@end
