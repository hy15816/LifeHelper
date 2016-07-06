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


#import "TestLoopViewController.h"
#import "LSTextView.h"
#import "NSString+TextHeight.h"
#import "NSString+YYAdd.h"

const CGFloat ZYTopViewH = 350;

@interface WiFiViewController ()
{
    BOOL _didAppear;
}
@property (strong,nonatomic) LSTextView *lsTextView;
@property (nonatomic,weak) UIImageView *topView;

@end

@implementation WiFiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self fetchSSIDInfo];
//    [self abc];
//    
//    [self address];
//    NNLog(@",,,,,,,,,,%@",[self getWIFIDic]);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"->" style:UIBarButtonItemStyleDone target:self action:@selector(goTestLoopView)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(ZYTopViewH * 0.5, 0, 0, 0);
    UIImageView *topView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error_-90164"]];
    topView.frame = CGRectMake(0, -ZYTopViewH, self.view.frame.size.width, ZYTopViewH);
    
    topView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.tableView insertSubview:topView atIndex:0];
    
    self.topView = topView;
    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _didAppear = YES;
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    });
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 1;
    }
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 || indexPath.section == 2) {
        static NSString *cellIden = @"agreementCells1";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIden];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"---------%ld",(long)indexPath.row];
        return cell;
    }else if (indexPath.section ==1){
        
        static NSString *cellIden = @"agreementCells2";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIden];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
//            [cell.contentView addSubview:self.lsTextView];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.numberOfLines = 0;
            
        }
        NNLog(@".w:%f",cell.textLabel.frame.size.width);
        cell.textLabel.text = [self cellText];
        if (!_didAppear) {
            [GlobalTool showActInView:cell.contentView];
        }else{
            [GlobalTool dismissAct:-1];
        }
        
        return cell;
    }
    
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
//        return [[self cellText] heightWithText:[self cellText] font:[UIFont systemFontOfSize:16] width:self.view.frame.size.width - 20 *2];
        return !_didAppear? 50.f : [[self cellText] sizeForFont:[UIFont systemFontOfSize:16] size:CGSizeMake(self.view.frame.size.width - 20 *2, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping].height;
    }
    
    return 50.f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat offsetH = -ZYTopViewH * 0.5 - offsetY;
    
    if (offsetH < 0) return;
    
    CGRect frame = self.topView.frame;
    frame.size.height = ZYTopViewH + offsetH;
    self.topView.frame = frame;
    
}

- (void)goTestLoopView {
    
    TestLoopViewController *test = [[TestLoopViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
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


- (LSTextView *)lsTextView{
    if (!_lsTextView) {
        _lsTextView = [[LSTextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _lsTextView.textColor = [UIColor grayColor];
        _lsTextView.font = [UIFont systemFontOfSize:16];
        _lsTextView.text = [self cellText];
        _lsTextView.editable = NO;
        _lsTextView.selectable = NO;
    }
    
    return _lsTextView;
}

- (NSString *)cellText{
    
    if (!_didAppear) {
        return @"";
    }
    
    return @"甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网甲乙双方本着相互信任，真诚合作的原则，经双方友好协商，就乙方为甲方 提供特定服务达成一致意见，特签订本合同(包括本合同附件A)。\n服务内容\n1、乙方同意向甲方提供附于本合同并作为本合同一部分的附件A所列的特定服务。 的内容、时限、衡量成果的标准见附件A。\n2、如果乙方在工作中因自身过错而发生任何错误或遗漏，乙方应无条件更正，而不另外收费，并对因此而对甲方造成的损失承担赔偿责任，赔偿以附件A所载明的该项服务内容对应之服务费为限。若因甲方原因造成工作的延误，将由甲方承担相应的损失。\n3、乙方的服务承诺：  1） 乙方接到甲方通过电话、信函传真、电子邮件、网";
}

#pragma mark - >>>>>>>>>>


@end
