//
//  ChartLineViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/29.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#define UULabelHeight       10
#define UUYLabelwidth       30

#import "ChartLineViewController.h"
#import "ChartView.h"

@interface ChartLineViewController ()

@property (strong, nonatomic) NSArray *xLabels;


@property (strong, nonatomic) NSMutableArray *showHorizonLine;


@end

@implementation ChartLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.xLabels = [[NSArray alloc] initWithObjects:@"10",@"23",@"45",@"70",@"39", nil];
    self.showHorizonLine = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4", nil];
    
    //[self drawGrade];
    
    ChartView *chart = [[ChartView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    chart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:chart];

}

/**
 *  画格子
 */
- (void)drawGrade {
    
    // 画横线
    
    CGFloat chartCavanHeight = self.view.frame.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight /4.0;
    //
    for (int i=0; i<5; i++) {
        if ([_showHorizonLine[i] integerValue]>0) {
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(UUYLabelwidth,UULabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(self.view.frame.size.width,UULabelHeight+i*levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 1;
            [self.view.layer addSublayer:shapeLayer];
        }
    }
    
    
    
    // 竖线
    
    CGFloat num = 0;
    if (self.xLabels.count>=20) {
        num=20.0;
    }else if (self.xLabels.count<=1){
        num=1.0;
    }else{
        num = self.xLabels.count;
    }
    
    CGFloat _xLabelWidth = (self.view.frame.size.width - UUYLabelwidth)/num;
    
    //画竖线
    for (int i=0; i<self.xLabels.count+1; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth,UULabelHeight)];
        [path addLineToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth,self.view.frame.size.height-2*UULabelHeight)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 1;
        [self.view.layer addSublayer:shapeLayer];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
