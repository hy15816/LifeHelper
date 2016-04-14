//
//  WeatherViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/21.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "WeatherViewController.h"
#import "HttpRequestObj.h"
#import "AddCityCollectionViewController.h"
#import "AddCityTableViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "MJRefresh.h"

@interface WeatherViewController ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService  *_locService;
    BMKGeoCodeSearch    *_geoSearch;
    NSString *_currentCityName;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addCityItem;
- (IBAction)addCityItemAction:(UIBarButtonItem *)sender;
/** 气温       */
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
/** 天气图标    */
@property (strong, nonatomic) IBOutlet UIImageView *weatherImageView;
/** 天气描述    */
@property (strong, nonatomic) IBOutlet UILabel *weatherDescribeLabel;
/** 体感(温度)  */
@property (strong, nonatomic) IBOutlet UILabel *bodyFellingLabel;
/** 发布时间    */
@property (strong, nonatomic) IBOutlet UILabel *releaseTimeLabel;
/** 空气质量    */
@property (strong, nonatomic) IBOutlet UILabel *airQualityLabel;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self initBMKLocation];
    [self initBMKGeoSearch];
//    
//    [self getWeatherInfoWithCity:@"北京" cityCode:@"101010100"];
    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        //刷新
//        [self getWeatherInfoWithCity:_currentCityName cityCode:nil];
//    }];
    
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        //
//        
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _locService.delegate = self;
    _geoSearch.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _locService.delegate = nil;
    _geoSearch.delegate = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBMKLocation {
    
    _locService = [[BMKLocationService alloc] init];
    _locService.distanceFilter = 200;
    //精度10米，定位要求的精度越高、属性distanceFilter的值越小，应用程序的耗电量就越大。
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //启动定位
    [_locService startUserLocationService];
}

- (void)initBMKGeoSearch {
    
    _geoSearch = [[BMKGeoCodeSearch alloc] init];

    
}
#pragma mark - 
/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser {
    
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser {
    
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    
}
//定位成功
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    NNLog(@"定位成功 == lat:%f,long:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    // 开始反地理编码
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_geoSearch reverseGeoCode:reverseGeoCodeSearchOption];
    
    if(flag) {
        
        NNLog(@"反Geo检索发送成功");
    } else {
        
        NNLog(@"反Geo检索发送失败");
        
        [AlertView showMessage:@"网络异常" time:1.5];
    }
    
    [_locService stopUserLocationService];
}

- (void)didFailToLocateUserWithError:(NSError *)error {
    
   
}

#pragma mark - BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    // 113.894145,22.943723
    NNLog(@"error:%d",error);
    if (error == BMK_SEARCH_NO_ERROR) {
        NNLog(@"%@%@%@%@%@",result.addressDetail.province, result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber);
        NSString *cityName = [result.addressDetail.city stringByReplacingOccurrencesOfString:@"市" withString:@""];
        _currentCityName = cityName;
        [self getWeatherInfoWithCity:cityName cityCode:nil];
    }else {
        NNLog(@"反地理编码失败");
    }
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    NNLog(@"%@%f,%f",result.address,result.location.latitude,result.location.longitude);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - get weather info
- (void)getWeatherInfoWithCity:(NSString *)cityName cityCode:(NSString *)code{
    
    //获取12天天气预报
//    [HttpRequestObj getWeatherInfoWithTwelveDays:cityName cityid:code showSVP:YES result:^(NSDictionary *result, NSError *error) {
//
//        //
//        if (!error) {
//            NNLog(@"result:%@",result);
//        }else {
//            NNLog(@"error:%@",error);
//        }
//    }];
    
    //查询可用城市列表
//    [HttpRequestObj getCityListAvailable:cityName showSVP:YES result:^(NSDictionary *result, NSError *error) {
//
//        if (!error) {
//            NNLog(@"result:%@",result);
//        }else {
//            NNLog(@"error:%@",error);
//        }
//    }];

    //根据cityCode获取天气信息
//    [HttpRequestObj getWeatherInfoWithCode:code showSVP:YES result:^(NSDictionary *result, NSError *error) {
//        if (!error) {
//            NNLog(@"result:%@",result);
//        }else {
//            NNLog(@"error:%@",error);
//        }
//    }];
    
    //天气查询 - 拼音
//    [HttpRequestObj getWeatherInfoWithPinYin:cityName showSVP:YES result:^(NSDictionary *result, NSError *error) {
//        if (!error) {
//            NNLog(@"result:%@",result);
//        }else {
//            NNLog(@"error:%@",error);
//        }
//    }];
    
    //天气查询 - 中文
    [HttpRequestObj getWeatherInfoWithChinase:cityName showSVP:YES result:^(NSDictionary *result, NSError *error) {
        
        dispatch_main(^{
            
            [self.tableView.mj_header endRefreshing];
            
        });
        if (!error) {
            NNLog(@"result:%@",result);
            [self parseWeatherInfoWithDic:result];
        }else {
            NNLog(@"error:%@",error);
        }
    }];
    
//    [HttpRequestObj getCityInfo:cityName showSVP:YES result:^(NSDictionary *result, NSError *error) {
//        if (!error) {
//            NNLog(@"result:%@",result);
//        }else {
//            NNLog(@"error:%@",error);
//        }
//    }];
    
}

- (void)parseWeatherInfoWithDic:(NSDictionary *)dic {
    
    NSString *errMsg = dic[@"errMsg"];
    NSInteger errNum = [dic[@"errNum"] integerValue];
    if (errNum == 0) {
        NNLog(@"查询成功！");
    }else {
        NNLog(@"查询失败！msg:%@",errMsg);
        return;
    }
    
    NSDictionary *retData = dic[@"retData"];
    
//    NSString *WD = dic[@"retData"][@"WD"];  //风向
//    NSString *WS = dic[@"retData"][@"WS"];  //风力
//    
//    NSString *sunrise = dic[@"retData"][@"sunrise"];  //日出
//    NSString *sunset = dic[@"retData"][@"sunset"];  //日落
    
    NSString *temp = dic[@"retData"][@"temp"];  //气温
    NSString *l_tmp = dic[@"retData"][@"l_tmp"];  //最低气温
    NSString *h_tmp = dic[@"retData"][@"h_tmp"];  //最高气温
    
    NSString *weather = retData[@"weather"];    //天气情况
    NSString *time = retData[@"time"];          //发布时间
    
//    NSString *citycode = retData[@"citycode"];
    
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@℃",temp];
    self.weatherDescribeLabel.text = [NSString stringWithFormat:@"%@ %@°~%@°",weather,l_tmp,h_tmp];
    self.releaseTimeLabel.text = [NSString stringWithFormat:@"%@ 发布",time];
    self.weatherImageView.image = [self weatherImage:weather];
}

- (UIImage *)weatherImage:(NSString *)weather {
    
    NSString *imageName = @"default";
    if ([weather isEqualToString:@"晴"]) {
        imageName = @"sunning";
    }
    if ([weather isEqualToString:@"小雨"]) {
        imageName = @"running_small";
    }
    if ([weather isEqualToString:@"中雨"]) {
        imageName = @"running_moderate";
    }
    if ([weather isEqualToString:@"大雨"]) {
        imageName = @"running_heavy";
    }
    if ([weather isEqualToString:@"暴雨"]) {
        imageName = @"running_storm";
    }
//    if ([weather isEqualToString:@"中雨"]) {
//        imageName = @"running";
//    }
    
    return [UIImage imageNamed:imageName];
}

#pragma mark -
- (IBAction)addCityItemAction:(UIBarButtonItem *)sender {
    
    AddCityTableViewController  *addCityVC = kStoryboardIndex(@"AddCityTableViewController");
//    AddCityCollectionViewController *addCityVC = kStoryboardIndex(@"AddCityCollectionViewController");
    [self.navigationController pushViewController:addCityVC animated:YES];
    
    
}
@end
