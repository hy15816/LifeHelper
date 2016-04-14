//
//  SettingsTableViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/22.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "SettingsTableViewController.h"
#import <MessageUI/MessageUI.h>

@interface SettingsTableViewController () <MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        // 发邮件
        // 1.MFMailComposeViewControllerDelegate
        // 2.[MFMailComposeViewController canSendMail]
        // 3.实现delegate
        [self sendMail];
        
        // 发信息
        // 1.<MFMessageComposeViewControllerDelegate>
        // 2.[MFMessageComposeViewController canSendText]
        // 3.实现delegate
//        [self sendMessage];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 
- (void)sendMessage {
    
    if( [MFMessageComposeViewController canSendText] ){
        // MFMessageComposeViewController提供了操作界面,这里我们创建一个相应的控制器
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
        controller.recipients = @[@"15298976973"];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        //显示发送信息界面的控制器
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        NNLog(@"设备不具备短信功能");
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    if (result == MessageComposeResultSent) {
        NNLog(@"发送成功");
        
    }else if (result == MessageComposeResultCancelled){
        NNLog(@"取消发送");
    }else if (result == MessageComposeResultFailed){
        NNLog(@"发送失败");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma makr - MFMailComposeViewControllerDelegate

- (void)sendMail {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        mailVC.mailComposeDelegate = self;
        [mailVC setToRecipients:@[@"hy15816@qq.com"]]; //邮件地址
        [mailVC setSubject:@"邮件主题-test"];           //邮件主题
        [mailVC setMessageBody:@"will send mail content" isHTML:NO];
        [self presentViewController:mailVC animated:YES completion:nil];
    }else {
        NNLog(@"设备不支持发邮件~~");
        [AlertView showMessage:@"设备不支发持邮件或未配置邮箱账号哦-.-!" time:2];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    NSString *msgString = @"未知错误";
    if (result == MFMailComposeResultSent) {
        NNLog(@"发送成功");
        msgString = @"发送成功";
    }else if (result == MFMailComposeResultCancelled){
        NNLog(@"取消发送");
        msgString = @"取消发送";
    }
    else if (result == MFMailComposeResultSaved){
        NNLog(@"已保存");
        msgString = @"已保存";
    }
    else if (result == MFMailComposeResultFailed){
        NNLog(@"发送失败");
        msgString = @"发送失败";
    }
    [AlertView showMessage:msgString time:1];
    sleep(1);
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
