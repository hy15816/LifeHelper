//
//  TuringViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "TuringViewController.h"
#import "HttpRequestObj.h"
#import "YYKeyboardManager.h"

@interface TuringViewController ()<YYKeyboardObserver>

@property (strong, nonatomic) IBOutlet UITextView *turingSayText;
@property (strong, nonatomic) IBOutlet UITextField *youSayField;
@property (strong, nonatomic) UIView *keyboardView;

- (IBAction)sendAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *youSayFieldBottomHeightContstraimt;

@property (strong, nonatomic) NSMutableString *talkString;

@property (strong,nonatomic) YYKeyboardManager *manager;

@end

@implementation TuringViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  2016-03-15 22:14:43.820 LifeHelper[4436:1550082] result:{
     "app_id" = 2300102;
     code = 100000;
     emojid = 0;
     faqAnswerId = 0;
     "show_text_after" = "";
     showtext = "\U60a8\U597d\Uff0c\U6211\U662f\U5c0f\U56fe\Uff0c\U6709\U4ec0\U4e48\U53ef\U4ee5\U5e2e\U60a8\U7684\U5417\Uff1f";
     tableName = "";
     "task_pos" = 1;
     tasklist =     (
     {
     delaytime = 0;
     duraltime = 1500;
     "task_id" = 1;
     type = 1;
     },
     {
     delaytime = 1700;
     duraltime = 1500;
     "task_id" = 1;
     type = 3;
     },
     {
     delaytime = 2900;
     duraltime = 1500;
     "task_id" = 1;
     type = 2;
     },
     {
     delaytime = 5600;
     duraltime = 1500;
     "task_id" = 1;
     type = 4;
     }
     );
     text = "\U60a8\U597d\Uff0c\U6211\U662f\U5c0f\U56fe\Uff0c\U6709\U4ec0\U4e48\U53ef\U4ee5\U5e2e\U60a8\U7684\U5417\Uff1f";
     "text_after" = "";
     "text_array" =     (
     {
     text = "\U60a8\U597d\Uff0c\U6211\U662f\U5c0f\U56fe\Uff0c\U6709\U4ec0\U4e48\U53ef\U4ee5\U5e2e\U60a8\U7684\U5417\Uff1f";
     "text_pitch" = 5;
     "text_sound" = 5;
     "text_speed" = 5;
     }
     );
     "user_reqid" = "0000000000145805128339958737145-123";
     }
     */
    
    
    // 备注：图灵网站 http://www.tuling123.com/
    
//    [self.view addSubview:self.keyboardView];
//    [self keyboardActions];
    
    self.talkString = [[NSMutableString alloc] init];
}

// 利用通知监听键盘 + 改变约束
- (void)keyboardDidChangedFrameNotify:(NSNotification *)notify {
    
    // 获得键盘的frame
    CGRect frame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.youSayFieldBottomHeightContstraimt.constant = self.view.frame.size.height - frame.origin.y;
    //    NNLog(@"constant:%f",self.view.frame.size.height - frame.origin.y);

    // 执行动画
    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        
        // 如果有需要,重新排版
        //[self.view layoutIfNeeded];
    }];
}

/**
 *  使用 YYKeyboardManager 键盘监听管理工具
 */
- (void)keyboardActions{
    
    // 获取键盘管理器
    self.manager = [YYKeyboardManager defaultManager];
    
    // 获取键盘的view 和window
//    UIView *view = self.manager.keyboardView;
//    UIWindow *window = self.manager.keyboardWindow;
    
    //获取键盘当前状态
//    BOOL visible = self.manager.keyboardVisible;
    CGRect frame = self.manager.keyboardFrame;
    frame = [self.manager convertRect:frame toView:self.view];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //监听键盘动画
    [self.manager addObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //移除监听键盘
    [self.manager removeObserver:self];
}
#pragma mark -
-(void)keyboardChangedWithTransition:(YYKeyboardTransition)transition {
    
    [UIView animateWithDuration:transition.animationCurve delay:0 options:transition.animationOption animations:^{
        CGRect kbFrame = [[YYKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
        CGRect textframe = self.youSayField.frame;
        textframe.size.width = kbFrame.size.width;
        textframe.origin.y = kbFrame.origin.y - textframe.size.height;
        self.youSayField.frame = textframe;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (UIView *)keyboardView {
    
    if (_keyboardView == nil) {
        _keyboardView = [UIView new];
        _keyboardView.backgroundColor = [UIColor greenColor];
        CGRect frame = CGRectZero;
        frame.size.width = DEVICE_WIDTH;
        frame.size.height = 50;
        frame.origin.y = DEVICE_HEIGHT - frame.size.height - 100;
        _keyboardView.frame = frame;
        
    }
    
    return _keyboardView;
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

- (IBAction)sendAction:(UIButton *)sender {
    
    [self.talkString appendFormat:@"我:%@ \n",self.youSayField.text];
    self.turingSayText.text = self.talkString;
    //滚动到最后一行
    [self.turingSayText scrollRectToVisible:CGRectMake(0, self.turingSayText.contentSize.height-15, self.turingSayText.contentSize.width, 10)  animated:YES];
    [HttpRequestObj turingWithInput:self.youSayField.text showSVP:YES result:^(NSDictionary *result, NSError *error) {
        //
        if (!error) {
            NNLog(@"result:%@",result);
            dispatch_main((^{
                //                self.turingSayLabel.text = result[@"showtext"];
                //self.turingSayLabel.text = result[@"text"];
                [self.talkString appendFormat:@"~:%@ \n",result[@"text"]];
                self.turingSayText.text = self.talkString;
                [self.turingSayText scrollRectToVisible:CGRectMake(0, self.turingSayText.contentSize.height-15, self.turingSayText.contentSize.width, 10)  animated:YES];
            }));
        }
        
    }];
    
    
}
@end
