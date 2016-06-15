//
//  TestLoopViewController.m
//  LifeHelper
//
//  Created by Lost_souls on 16/5/21.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "TestLoopViewController.h"
#import "LSLoopView.h"
#import "SDCycleScrollView.h"

@interface TestLoopViewController ()<LSLoopViewDelegate>

@end

@implementation TestLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *images = [NSMutableArray arrayWithObjects:@"placeholder",@"navbg",@"placeholder", nil];
//    LSLoopView *loop = [LSLoopView loopViewWithFrame:CGRectMake(0, 65, DEVICE_WIDTH, 200) delegate:self imagesArray:images titleArray:nil];
//    loop.tag = 1001;
//    [self.view addSubview:loop];
    
    
    NSMutableArray *imagesURL = [NSMutableArray arrayWithObjects:@"http://c.hiphotos.baidu.com/image/pic/item/a044ad345982b2b782d814fd34adcbef76099b47.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/34fae6cd7b899e51601a7b9c40a7d933c9950da5.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/a044ad345982b2b782d814fd34adcbef76099b47.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/a044ad345982b2b782d814fd34adcbef76099b47.jpg", nil];
    LSLoopView *loop2 = [LSLoopView loopViewWithFrame:CGRectMake(0, 65, DEVICE_WIDTH, 350) delegate:self imagesURLArray:imagesURL titleArray:nil placeholder:@"placeholder"];

    loop2.loopTimeInterval = 5;
    loop2.backgroundColor = [UIColor blueColor];
    loop2.tag = 1002;
    [self.view addSubview:loop2];
    
    
    
//    LSLoopView *loop3 = [[LSLoopView alloc] initWithFrame:CGRectMake(0, 300, DEVICE_WIDTH, 350) imagesArray:images titleArray:nil selectedBlock:^(LSLoopView *loopView, NSInteger index) {
//        //
//    }];
//    LSLoopView *loop3 = [LSLoopView ls_loopViewWithFrame:CGRectMake(0, 300, DEVICE_WIDTH, 350) imagesArray:images titleArray:nil selectedBlock:^(LSLoopView *loopView, NSInteger index) {
//    
//        NNLog(@"index:%d",index);
//    }];
//    loop3.backgroundColor = [UIColor redColor];
//    [self.view addSubview:loop3];
    
    
//    SDCycleScrollView *cyView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 300, DEVICE_WIDTH, 350) imagesGroup:images];
//    [self.view addSubview:cyView];
    
    
    LSLoopView *loop4 = [LSLoopView ls_loopViewWithFrame:CGRectMake(0, 450, DEVICE_WIDTH, 150) imagesURLArray:imagesURL titleArray:nil placeholder:@"placeholder" selectedBlock:^(LSLoopView *loopView, NSInteger index) {
        //
        NNLog(@"index:%ld",(long)index);
    }];
    
    [self.view addSubview:loop4];
    
}

- (void)loopView:(LSLoopView *)loopView didSelectItem:(NSInteger)index {
    
    NNLog(@"tag : %ld----index:%ld",(long)loopView.tag,(long)index);
    
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
