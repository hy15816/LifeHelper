//
//  TestViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/21.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#define XBgColor [UIColor colorWithRed:1 green:0.44305463149037339  blue:0.12740626975406666  alpha:1.0]

#import "TestViewController.h"

@interface TestViewController ()
{
    BOOL _hidenStatusBar;
}
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    if (kIOS_7) {
//        //
//        NNLog(@"is ios 7");
//        [self.navigationController.navigationBar setBarTintColor:XBgColor];
//    }else {
    
//        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbg"] forBarMetrics:UIBarMetricsDefault];
    
        // 设置导航栏按钮的背景图片
//        UIBarButtonItem *barItem = [UIBarButtonItem appearance];
//        [barItem setBackgroundImage:[UIImage imageNamed:@"NavButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [barItem setBackgroundImage:[UIImage imageNamed:@"NavButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        
        
        // 设置导航栏返回按钮的背景图片
//        [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButton"]forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButtonPressed"]forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        
//    }
    
    
    
    
}

//- (BOOL)prefersStatusBarHidden {
//    
//    [super prefersStatusBarHidden];
//    
//    return NO;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
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
