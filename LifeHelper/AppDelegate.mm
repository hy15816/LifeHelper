//
//  AppDelegate.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//



#import "AppDelegate.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()<BMKGeneralDelegate,CLLocationManagerDelegate>

{
    BMKMapManager *_bmkMapManager;
    UIBackgroundTaskIdentifier bgTask;
    dispatch_source_t _dispatch_source_timer;
}

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSTimer *backgroundTimer;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self regBMKMap];
    [self registerNotification];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //判断是否模拟器 1-YES,0-NO
    BOOL is_phone_simulator = TARGET_IPHONE_SIMULATOR;
    BOOL isOpenRunningBackground = NO;
    
    NSLog(@"is_phone_simulator:%d,isOpenRunningBackground:%d",is_phone_simulator,isOpenRunningBackground);
    if (is_phone_simulator && isOpenRunningBackground) {
        [self requestTimes];
    }
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // endBackgroundTask
    [self endBackgroundTask];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [self stopLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Baidu Map
// 注册百度地图
- (void)regBMKMap{
    
    _bmkMapManager = [[BMKMapManager alloc] init];
    BOOL reg = [_bmkMapManager start:kBMKMAP_APP_KEY generalDelegate:self];
    if (!reg) {
        NSLog(@"bmk manager start failed!");
    }
    
}

// - <BMKGeneralDelegate>
/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError {
    
}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError {
    
}

#pragma mark - 注册通知
/**
 *  注册通知
 */
- (void)registerNotification {
    
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
        //[self addLocalNotification];
    }else{
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
    }
}


#pragma mark - 申请后台运行时间
/**
 *  申请后台运行时间
 *
 */
- (void)requestTimes{
    
    UIApplication* app = [UIApplication sharedApplication];
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    // Start the long-running task and return immediately.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //在下面写你要在后台运行的代码
        // 1.gcd+player
        [self startTimes_gcd];
        
        // 2.NSTimer + location
        //[self startTimes_timer];
        
    });
}

/**
 *  结束后台运行进程
 */
- (void)endBackgroundTask {
    
    [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    bgTask = UIBackgroundTaskInvalid;
    if (_dispatch_source_timer) {
        dispatch_source_cancel(_dispatch_source_timer);
    }
    
}


#pragma mark - 1.利用播放音频的方式
// 由于BackgroundTas不能在程序已经进入后台时申请，可以用一个播放音乐的假前台状态去申请，所以可以做到不断申请到权限。完成长时间后台运行
- (void)playMusic:(NSString *)musicNames {
    
    [self.audioPlayer pause];
    self.audioPlayer = nil;
    
    //设置
    NSError *avaudioError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&avaudioError];
    
    NSError *activeError = nil;
    [[AVAudioSession sharedInstance] setActive: YES error: &activeError];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:musicNames ofType:@"mp3"];
    if (!path) {
        NSLog(@"未找到该歌曲！");
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *playerError = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&playerError];
    self.audioPlayer.pan = 0;//0，1右，-1左声道
    self.audioPlayer.volume = 0;//音量
    self.audioPlayer.numberOfLoops = -1;//单曲循环
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    
    // 同时申请运行时间
    [self requestTimes];
}

/**
 *  运行一个定时器 GCD方法
 */
- (void)startTimes_gcd {
    
    //倒计时时间
    __block NSInteger timeOut = 0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _dispatch_source_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //    _dispatch_source_timer = _timer;
    //每60秒执行一次
    dispatch_source_set_timer(_dispatch_source_timer, dispatch_walltime(NULL, 0), 60.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_dispatch_source_timer, ^{
        
        //倒计时结束，关闭
        //        if (timeOut <= 0) {
        //            dispatch_source_cancel(_dispatch_source_timer);
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                NSLog(@"....................time out");
        //            });
        //        } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            float backgroundtime = [[UIApplication sharedApplication] backgroundTimeRemaining];
            NSLog(@"backgroundTimeRemaining:%d",(int)backgroundtime);
            if ([[UIApplication sharedApplication] backgroundTimeRemaining] <= 100) {
                NSLog(@"=============== time <= 10 ===========");
                //关闭当前定时器
                if (_dispatch_source_timer) {
                    dispatch_source_cancel(_dispatch_source_timer);
                }
                //再次申请加时
                [self playMusic:@"cnhk"];
            }
            
            NSLog(@"....................time :%ld",(long)timeOut);
            //                if (timeOut %20 == 0) {
            
            //发送一个本地通知
            [self presentLocalNotification:[NSString stringWithFormat:@"%ld",(timeOut-1) * 60]];
            //                }
            // 后台运行时间小于0时，退出
            if ([[UIApplication sharedApplication] backgroundTimeRemaining] <= 0) {
                if (_dispatch_source_timer) {
                    dispatch_source_cancel(_dispatch_source_timer);
                }
                return ;
            }
            
        });
        timeOut++;
        //        }
    });
    dispatch_resume(_dispatch_source_timer);
}

#pragma mark - 2.利用定位
/**
 *  运行一个定时器 NSTimer
 */
- (void)startTimes_timer {
    
    //    if (self.backgroundTimer == nil) {
    dispatch_main(^{
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(backgroundTimerAction) userInfo:nil repeats:YES];
        self.backgroundTimer = timer;
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    });
    
    //    }
    
}

- (void)backgroundTimerAction {
    
    
    float backgroundtime = [[UIApplication sharedApplication] backgroundTimeRemaining];
    NSLog(@"backgroundTimeRemaining:%d",(int)backgroundtime);
    if ([[UIApplication sharedApplication] backgroundTimeRemaining] <= 100) {
        NSLog(@"=============== backgroundTimeRemaining <= 100 ===========");
        //关闭当前定时器
        [self.backgroundTimer invalidate];
        self.backgroundTimer = nil;
        //再次申请加时
        [self startLocation];
        [self startTimes_timer];
    }
    
    //发送一个本地通知
    [self presentLocalNotification:[NSString stringWithFormat:@"%d",0]];
    [self startLocation];
    
    // 后台运行时间小于0时，退出
    if ([[UIApplication sharedApplication] backgroundTimeRemaining] <= 0) {
        [self stopLocation];
        return ;
    }
    
}

- (void)startLocation {
    
    [self.locationManager startUpdatingLocation]; //定位
    [self.locationManager startMonitoringSignificantLocationChanges];   //位置变化
}

- (void)stopLocation {
    
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopMonitoringSignificantLocationChanges];
    [self.backgroundTimer invalidate];
    self.backgroundTimer = nil;
}

- (CLLocationManager *)locationManager {
    
    if (![CLLocationManager locationServicesEnabled]) {
        
        NSLog(@"您已关闭了定位。。。。。。。。。请打开");
        return nil;
    }
    
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer; //设置监测千米级别,降低能耗
        _locationManager.pausesLocationUpdatesAutomatically = NO; //该模式是抵抗ios在后台杀死程序设置，iOS会根据当前手机使用状况会自动关闭某些应用程序的后台刷新，该语句申明不能够被暂停，但是不一定iOS系统在性能不佳的情况下强制结束应用刷新
        if (kIOS_8) {
            [_locationManager requestWhenInUseAuthorization];   //在使用时定位
            [_locationManager requestAlwaysAuthorization];      //后台也可以定位
        }
        
        if (kIOS_9) {
            _locationManager.allowsBackgroundLocationUpdates = YES;
        }
        
        
    }
    
    return _locationManager;
}
#pragma mark - location delegate <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    if (!locations.count) {
        return;
    }
    CLLocation *location = locations[0];
    NSLog(@"didUpdateLocations-- lat:%f,long:%f",location.coordinate.latitude,location.coordinate.longitude);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    
}

#pragma mark - 发出一个本地通知
/**
 *  发出一个通知
 */
- (void)presentLocalNotification:(NSString *)times {
    
    
    //定义本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    if (notification == nil) {
        return;
    }
    //设置调用时间
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:2.0];//通知触发的时间，10s以后
    
    notification.repeatInterval=2;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=[NSString stringWithFormat:@"后台运行持续时间: %@ 秒",times]; //通知主体
    notification.applicationIconBadgeNumber=[UIApplication sharedApplication].applicationIconBadgeNumber + 1;//应用程序图标右上角显示的消息数
    notification.alertAction=@"查看详情"; //待机界面的滑动动作提示
    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    notification.soundName=@"msg.caf";//通知声音
    
    //设置用户信息
    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    
}

@end
