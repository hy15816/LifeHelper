//
//  WiFiViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/6.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "WiFiViewController.h"

#import <SystemConfiguration/CaptiveNetwork.h>
#import "dlfcn.h"

#import <SystemConfiguration/SCDynamicStore.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

@interface WiFiViewController ()

@end

@implementation WiFiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fetchSSIDInfo];
    [self abc];
    
    [self address];
    
    NNLog(@",,,,,,,,,,%@",[self getWIFIDic]);
    
}

- (id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();

    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NNLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return info;
}

/**
 *  获取当前连接wifi的名称、地址、data
 */
- (void)abc {
    
    NSString *ssid = @"";
    NSString *mac = @"";
    CFArrayRef myArray = CNCopySupportedInterfaces(); //获取wifi列表 ，实际返回的只有当前连接的哪个wifi
    NNLog(@"myArray:%@",myArray);
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            
            ssid = [dict valueForKey:@"SSID"];      // 名称
            mac = [dict valueForKey:@"BSSID"];      // 路由器地址
            NSData *ssidData = [dict valueForKey:@"SSIDDATA"];  //名称data
            NNLog(@"%@,,%@,,%@,,%@",ssid,mac,ssidData,dict);
            NNLog(@"....... %@",[[NSString alloc] initWithData:ssidData encoding:NSUTF8StringEncoding]);
        }
    }
}


/**
 *  获取网卡ip     http://www.cocoachina.com/ios/20150210/11110.html
 */
- (void) address {
    
    
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor ->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    break;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    NNLog(@"localIP:%@",localIP) ;
    
    
}

// 获取网卡信息
- (NSDictionary *)getWIFIDic
{
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dic = (NSDictionary*)CFBridgingRelease(myDict);
            return dic;
        }
    }
    return nil;
}

- (NSString *)getBSSID
{
    NSDictionary *dic = [self getWIFIDic];
    if (dic == nil) {
        return nil;
    }
    return dic[@"BSSID"];
}

- (NSString *)getSSID
{
    NSDictionary *dic = [self getWIFIDic];
    if (dic == nil) {
        return nil;
    }
    return dic[@"SSID"];
}

// 向ios系统注册ssid，
- (void)registerNetwork:(NSString *)ssid
{
    NSString *values[] = {ssid};
    CFArrayRef arrayRef = CFArrayCreate(kCFAllocatorDefault,(void *)values,
                                        (CFIndex)1, &kCFTypeArrayCallBacks);
    if( CNSetSupportedSSIDs(arrayRef)) {
        NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
        CNMarkPortalOnline((__bridge CFStringRef)(ifs[0]));
        NNLog(@"%@", ifs);
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - >>>>>>>>>>


@end
