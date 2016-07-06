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
#import "ChartGrideView.h"
#import "LSChartView.h"

@interface ChartLineViewController ()<LSChartViewDataSource>
{
    BOOL _isOne;
}
@property (strong, nonatomic) NSArray *xLabels;


@property (strong, nonatomic) NSMutableArray *showHorizonLine;

@property (strong,nonatomic) LSChartView *chartGride;

@end

@implementation ChartLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor brownColor];
    
    self.xLabels = [[NSArray alloc] initWithObjects:@"10",@"23",@"45",@"70",@"39", nil];
    self.showHorizonLine = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4", nil];
    
    //[self drawGrade];
    
    ChartView *chart = [[ChartView alloc] initWithFrame:CGRectMake(50, 64, DEVICE_WIDTH-100, DEVICE_HEIGHT-64)];
    chart.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:chart];
    
//    _chartGride = [[ChartGrideView alloc] initWithFrame:CGRectMake(20, 100, DEVICE_WIDTH-40, 150) dataSource:self];
    
    _chartGride = [[LSChartView alloc] initWithFrame:CGRectMake(20, 100, DEVICE_WIDTH-40, 150) dataSource:self];
    
    _chartGride.backgroundColor = [UIColor clearColor];
    
    _chartGride.textColor = [UIColor whiteColor];
    _chartGride.chartPointColor = [UIColor whiteColor];
    _chartGride.chartLineColor = [UIColor whiteColor];
    _chartGride.isHollow = YES;
    
    [_chartGride showInView:self.view points:@[@"100",@"150",@"80",@"200",@"500",@"390",@"100",@"570"]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refreshItem)];
    
//    [self.view addSubview:chartGride];
}

- (void)refreshItem{
    
    _isOne = !_isOne;
    NSArray *points;// = @[@"100",@"150",@"80",@"200",@"500",@"390",@"100",@"570"];
    if (_isOne) {
        points = @[@"10",@"15",@"8",@"20",@"40",@"39"];
    }else{
        points = @[@"100",@"150",@"80",@"200",@"500",@"390",@"100",@"570",@"600",@"500"];
    }
    [_chartGride reloadData:points];
}

- (NSArray *)chartViewHorizontalTitles:(ChartGrideView *)chartView{
    if (_isOne) {
        return @[@"10",@"20",@"30",@"40"];
    }
    return @[@"100",@"200",@"300",@"400",@"500",@"600"];
}

- (NSArray *)chartViewVerticalTitles:(ChartGrideView *)chartView{
    
    if (_isOne) {
        return @[@"1",@"2",@"3",@"4",@"5",@"6"];
    }
    return @[@"5.3",@"5.9",@"5.16",@"5.23",@"5.30",@"6.6",@"6.13",@"6.20",@"6.27",@"7.3"];
}

- (UIColor *)backgroundLineColor{
    
    return [UIColor whiteColor];
}
- (CGFloat)backgroundLineWidth{
    return 0.5f;
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
