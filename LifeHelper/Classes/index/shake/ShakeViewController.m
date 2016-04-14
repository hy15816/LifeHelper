//
//  ShakeViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/22.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "ShakeViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "ChartView.h"

typedef NS_ENUM(NSInteger,MontionAccDataType) {
    
    MontionAccDataTypePush = 0,
    MontionAccDataTypePull
};

@interface ShakeViewController ()<UIAccelerometerDelegate>
{
    ChartView *chartView;
    float _values;
}
@property (strong,nonatomic) CMMotionManager *motionManager;

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self getBundleInfo];
//    [self addBatteryStateChangedNoti];
//    [self getDeviceInfo];
//    [self testProximity];
//    [self testDeviceOrientation];
    
//    [self testMotion];
    
    chartView = [[ChartView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 150) progress:YES];
    [self.view addSubview:chartView];
    
    chartView.trackColor = [UIColor blueColor];
    chartView.progressColor = [UIColor redColor];
    chartView.progress = .2f;
    chartView.progressWidth = 20;
    
    _values = 0.2f;
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(change) userInfo:nil repeats:YES];
    
}

- (void)change {
    _values += 0.01;
    [chartView setProgress:_values animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)becodeQRImage{
    
    
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






#pragma mark - 获取Proj bundle info
- (void)getBundleInfo {
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"app bundel info:%@",info);
    NSLog(@"app display name :%@",[info stringForKey:@"CFBundleDisplayName"]);
    NSLog(@"device UUIDString:%@",[[UIDevice currentDevice] identifierForVendor].UUIDString); //8C1D4C41-2C03-41ED-9CC5-3998FCA53E8F
    NSLog(@"[UIDevice currentDevice]:%@",[UIDevice currentDevice]);
}






#pragma mark - 电池电量
- (void)addBatteryStateChangedNoti {
    
    UIDevice *device = [UIDevice currentDevice];
    
    //开启电池检测
    device.batteryMonitoringEnabled = YES;
    
    //注册通知，当充电状态改变时调用batteryStateChange方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryStateChange) name:UIDeviceBatteryStateDidChangeNotification object:nil];
    
}

- (void)batteryStateChange {
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *string = @"电量未知";
    switch (device.batteryState) {
        case UIDeviceBatteryStateUnplugged:
            string = @"未充电";
            break;
        case UIDeviceBatteryStateCharging:
            string = @"充电中";
            break;
        case UIDeviceBatteryStateFull:
            string = @"已充满";
            break;
        default:
            break;
    }
    
    NNLog(@"%@:%.f%@",string,device.batteryLevel *100,@"%");
}

#pragma mark - 设备属性
- (void)getDeviceInfo {
    
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;  //开启电量检测
    NSLog(@"+----------------------------------------------------------------");
    NSLog(@"+   device name             :%@",device.name);
    NSLog(@"+   device model            :%@",device.model);
    NSLog(@"+   device systemName       :%@",device.systemName);
    NSLog(@"+   device systemVersion    :%@",device.systemVersion);
    NSLog(@"+   device UUID             :%@",device.identifierForVendor.UUIDString);
    NSLog(@"+   device localizedModel   :%@",device.localizedModel);
    NSLog(@"+   device battery          :%.f%@",device.batteryLevel *100,@"%");
    NSLog(@"+-----------------------------------------------------------------");
}

#pragma mark - 接近传感器~
/**
 *  接近传感器~~
 */
- (void)testProximity {
    // 相关属性
    /**
     *  @property(nonatomic,getter=isProximityMonitoringEnabled) BOOL proximityMonitoringEnabled ; // 接近传感器是否生效，默认情况下不生效
        @property(nonatomic,readonly) BOOL proximityState ;  //接近传感器工作状态
     
     //系统提供的内置通知，当传感器工作时会触发通知
     UIKIT_EXTERN NSString *const UIDeviceProximityStateDidChangeNotification;
     */
    
    // 示例
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;  //启用接近传感器
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateChange) name:UIDeviceProximityStateDidChangeNotification object:nil];
    
    
}

- (void)proximityStateChange {
    
    if ([UIDevice currentDevice].proximityState == YES) {
        NNLog(@"物体靠近");
    }else {
        NNLog(@"物体离开");
    }
}

#pragma mark - 方向传感器
- (void)testDeviceOrientation {
    
    //开启方向改变通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //注册方向改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    // 注意:检测时需要解开手机的锁定竖屏状态
}

- (void)deviceOrientationChange {
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *orientationString = [[NSString alloc] init];
    switch (device.orientation) {
        case UIDeviceOrientationPortrait:
            orientationString = [NSString stringWithFormat:@"竖屏/正常"];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientationString = [NSString stringWithFormat:@"竖屏/倒置"];
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            orientationString = [NSString stringWithFormat:@"横屏/左侧"];
            break;
        case UIDeviceOrientationLandscapeRight:
            orientationString = [NSString stringWithFormat:@"横屏/右侧"];
            break;
        case UIDeviceOrientationFaceUp:
            orientationString = [NSString stringWithFormat:@"正面朝上"];
            break;
        case UIDeviceOrientationFaceDown:
            orientationString = [NSString stringWithFormat:@"正面朝下"];
            break;
            
        default:
            orientationString = [NSString stringWithFormat:@"未知朝向"];
            break;
    }
    
    NNLog(@"deviceOrientationChange == %@",orientationString);
}


#pragma mark - 加速计 & 陀螺仪 & 磁力计
// 一、加速计
- (void)testMotion {
    
    if (self.motionManager == nil) {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    
    
    [self startAcc:MontionAccDataTypePush];
    
}

- (void)startAcc:(MontionAccDataType)type {
    
    if (type == MontionAccDataTypePush) {
        // 1.push模式
        //设置采样间隔
        self.motionManager.accelerometerUpdateInterval = 1.0;
        //开始采样<会自动运行定时器，间隔:accelerometerUpdateInterval>
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
            NNLog(@"x:%f, y:%f, z:%f",accelerometerData.acceleration.x, accelerometerData.acceleration.y,accelerometerData.acceleration.z);
            
        }];
    }else {
        
        // 2.pull 模式
        if (self.motionManager.isAccelerometerAvailable) {
            //启动采样
            [self.motionManager startAccelerometerUpdates];
        }else {
            NNLog(@"加速计Accelerometer不可用");
        }
        [self performSelector:@selector(getAccelerometerData) withObject:nil afterDelay:3];
    }

}

- (void)getAccelerometerData {
    
    //获取加速计当前状态
    CMAcceleration  acceleration = self.motionManager.accelerometerData.acceleration;
    NNLog(@"accelerometer current state：x:%f, y:%f, z:%f", acceleration.x, acceleration.y, acceleration.z);
}

- (void)stopAcc {
    
    [self.motionManager stopAccelerometerUpdates];
    
}

// 二、陀螺仪
- (void)testGyro {
    
    if (self.motionManager == nil) {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    
    [self startGyro:MontionAccDataTypePush];
    
}
- (void)startGyro:(MontionAccDataType)type {
    
    if (type == MontionAccDataTypePush) {
        // 1.push 模式
        //设置采样间隔
        self.motionManager.gyroUpdateInterval = 1.0;
        //开始采样
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            NNLog(@"x:%f, y:%f, z:%f", gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z);
        }];
    }else {
        // 2. pull 模式
        if (self.motionManager.isGyroAvailable) {
            [self.motionManager startGyroUpdates];
        }else {
            NNLog(@"陀螺仪GyroScope不可用");
        }
        [self performSelector:@selector(getGyroData) withObject:nil afterDelay:3];
    }
    
}
/**
 *  获取陀螺仪当前状态
 */
- (void)getGyroData {
    
    //获取陀螺仪当前状态
    CMRotationRate rationRate = self.motionManager.gyroData.rotationRate;
    NNLog(@"gyroscope current state: x:%f, y:%f, z:%f", rationRate.x, rationRate.y, rationRate.z);
}
/**
 *  停止
 */
- (void)stopGyro {
    
    [self.motionManager stopGyroUpdates];
}

// 三、磁力计
- (void)testMagneto {
    
    if (self.motionManager == nil) {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    
    [self startMagneto:MontionAccDataTypePush];
}

- (void)startMagneto:(MontionAccDataType)type {
    
    if (type == MontionAccDataTypePush) {
        // 1.push
        //设置采样间隔
        self.motionManager.magnetometerUpdateInterval = 1.0;
        //开始采样
        [self.motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
            NNLog(@"x:%f, y:%f, z:%f", magnetometerData.magneticField.x, magnetometerData.magneticField.y, magnetometerData.magneticField.z);
        }];
    }else {
        //Pull模式--磁力计
        if (self.motionManager.isMagnetometerAvailable) {
            [self.motionManager startMagnetometerUpdates];
        }else {
            NNLog(@"磁力计Magnetometer不可用");
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //获取磁力计当前状态
            CMMagneticField magneticField = self.motionManager.magnetometerData.magneticField;
            NNLog(@"magnetometer current state: x:%f, y:%f, z:%f", magneticField.x,magneticField.y,magneticField.z);

        });
    }
}

- (void)stopMagneto {
    
    [self.motionManager stopMagnetometerUpdates];
}


@end
