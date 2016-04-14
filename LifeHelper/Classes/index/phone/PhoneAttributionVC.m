//
//  PhoneAttributionVC.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "PhoneAttributionVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "MPNotificationView.h"

@interface PhoneAttributionVC ()<UITextFieldDelegate,AVAudioSessionDelegate>

@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutlet UITextField *inputField;
@property (strong, nonatomic) IBOutlet UILabel *tipsLabel;
- (IBAction)searchButtonAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *volumeView;
@property (strong, nonatomic) IBOutlet UIImageView *minVolumeImg;
@property (strong, nonatomic) IBOutlet UIImageView *maxVolumeImg;


@end

@implementation PhoneAttributionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.inputField.delegate = self;
    self.resultLabel.text = nil;
    self.tipsLabel.text = nil;

    [self earphoneInOrOut];
    
}


#pragma mark -
/**
 *  监听耳机是否接入
 */
- (void)earphoneInOrOut{
    
    // #import <AVFoundation/AVFoundation.h>
    // <AVAudioSessionDelegate>
    
    // 设置 Category
//    NSError *cError;
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&cError];
//    [AVAudioSession sharedInstance];
//    if (cError) {
//        NNLog(@"error:%@",cError);
//        return;
//    }
    
    NSError *avaudioError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&avaudioError];
    
    NSError *activeError = nil;
    [[AVAudioSession sharedInstance] setActive: YES error: &activeError];
    
    // 监听耳机状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionRouteChangeNoti:) name:AVAudioSessionRouteChangeNotification object:nil];
    
}

- (void)sessionRouteChangeNoti:(NSNotification *)noti {
    
//    NNLog(@"sessionRouteChangeNoti--[noti userInfo]:%@",[noti userInfo]);
    NSInteger route = [[noti userInfo][AVAudioSessionRouteChangeReasonKey] integerValue];
    NNLog(@"1:有线耳机 ^^^^^^ 2:扬声器。。route:%ld",(long)route);
}

/**
 *  添加系统音量控制
 */
- (void)addSystemVolumeControl {
    
    // #import <MediaPlayer/MediaPlayer.h>

    //音量控制
    self.minVolumeImg.image = [UIImage imageNamed:@"volume1"];
    self.maxVolumeImg.image = [UIImage imageNamed:@"volume2"];
    self.volumeView.userInteractionEnabled = YES;
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    volumeView.frame=CGRectMake(45, self.volumeView.frame.size.height/3.2,  self.view.frame.size.width *.7, 2);
    [volumeView setShowsVolumeSlider:YES];
    [volumeView setShowsRouteButton:NO];
    [volumeView sizeToFit];     // <加了这句可以滑动滑块...？>
    [self.volumeView addSubview:volumeView];
    
    /*  @optional
    UISlider *volumeSlider = nil;
    for (UIView *view in volumeView.subviews) {
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]) {
            volumeSlider = (UISlider *)view;
            volumeSlider.maximumTrackTintColor = [UIColor redColor];
            volumeSlider.minimumTrackTintColor = [UIColor yellowColor];
            volumeSlider.minimumValueImage = [UIImage imageNamed:@"volume1"];
            volumeSlider.maximumValueImage = [UIImage imageNamed:@"volume2"];
            //            [volumeSlider setMaximumTrackImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
            //            [volumeSlider setMinimumTrackImage:[UIImage imageNamed:@"12"] forState:UIControlStateSelected];
            break;
        }
    }
    volumeSlider.value = .5;
    [volumeSlider addTarget:self action:@selector(volumeSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    */
    
    //    //方法2，显示图标
    //    MPMusicPlayerController *music = [MPMusicPlayerController applicationMusicPlayer];
    //    music.volume = .2f;
    
    // 监听按键改变的音量
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemVolumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    
}

- (void)systemVolumeChanged:(NSNotification *)noti {
    
    
    NNLog(@"[noti userInfo]:%@",[noti userInfo]);
}

- (void)volumeSliderValueChanged:(UISlider *)slider {
    
    NNLog(@"...........");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self search];
    
    return YES;
}

#pragma mark - search

- (void)search {
    
    [self.inputField resignFirstResponder];
    
    [HttpRequestObj getNumberOfAttributionShowSVP:YES phoneNum:self.inputField.text result:^(NSDictionary *result, NSError *error) {
        //
        dispatch_main((^{
            if (error) {
                NNLog(@"err:%@",error);
                
            }else {
                
                if ([result[@"errNum"] integerValue] == 0) {
                    NSDictionary *retData = result[@"retData"];
                    self.resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",
                                             retData[@"province"],
                                             retData[@"city"],
                                             retData[@"supplier"],
                                             retData[@"suit"]];
                }else {
                    
                    self.resultLabel = nil;
                    self.tipsLabel.text = result[@"retMsg"];
                    [MPNotificationView notifyWithText:result[@"retMsg"]];
                }
                
            }
        }));
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchButtonAction:(UIButton *)sender {
    
    [self search];
}
@end
