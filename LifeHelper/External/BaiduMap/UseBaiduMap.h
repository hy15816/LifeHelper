//
//  UseBaiduMap.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/23.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#ifndef UseBaiduMap_h
#define UseBaiduMap_h


#endif /* UseBaiduMap_h */


/**
 *  
 
 1.申请秘钥
 2.让应用支持http :在Info添加：NSAppTransportSecurity--NSAllowsArbitraryLoads:ture
 3.在ios9调起百度地图客户端，先添加:LSApplicationQueriesSchemes -- baidumap
 4.管理地图的生命周期：自2.0.0起，BMKMapView新增viewWillAppear、viewWillDisappear方法来控制BMKMapView的生命周期，并且在一个时刻只能有一个BMKMapView接受回调消息，因此在使用BMKMapView的viewController中需要在viewWillAppear、viewWillDisappear方法中调用BMKMapView的对应的方法，并处理delegate，代码如下：
    -(void)viewWillAppear:(BOOL)animated
    {
        [_mapView viewWillAppear];
        _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    }
    
    -(void)viewWillDisappear:(BOOL)animated
    {
        [_mapView viewWillDisappear];
        _mapView.delegate = nil; // 不用时，置nil
    }
 
 5.静态库中采用ObjectC++实现，因此需要您保证您工程中至少有一个.mm后缀的源文件(您可以将任意一个.m后缀的文件改名为.mm)，或者在工程属性中指定编译方式，即将Xcode的Project -> Edit Active Target -> Build -> GCC4.2 - Language -> Compile Sources As设置为"Objective-C++"
 
 6.自iOS SDK v2.5.0起，为了对iOS8的定位能力做兼容，做了相应的修改，开发者在使用过程中注意事项如下： 需要在info.plist里添加（以下二选一，两个都添加默认使用NSLocationWhenInUseUsageDescription）：
    NSLocationWhenInUseUsageDescription ，允许在前台使用时获取GPS的描述
    NSLocationAlwaysUsageDescription ，允许永久使用GPS的描述
 
 7.在使用Xcode6进行SDK开发过程中，需要在info.plist中添加：Bundle display name ，且其值不能为空（Xcode6新建的项目没有此配置，若没有会造成manager start failed）
 
 8.app在前后台切换时，需要使用下面的代码停止地图的渲染和openGL的绘制：
    - (void)applicationWillResignActive:(UIApplication *)application {
        [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
    }
 
    - (void)applicationDidBecomeActive:(UIApplication *)application {
        [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
    }
 
 
 9.需要添加的framework:【CoreLocation.framework和QuartzCore.framework、OpenGLES.framework、SystemConfiguration.framework、CoreGraphics.framework、Security.framework、libsqlite3.0.tbd（xcode7以前为 libsqlite3.0.dylib）、CoreTelephony.framework 、libstdc++.6.0.9.tbd（xcode7以前为libstdc++.6.0.9.dylib）】
 
 10. 在TARGETS->Build Settings->Other Linker Flags 中添加-ObjC。
 
 
 
 */
