//
//  LockViewController.m
//  LifeHelper
//
//  Created by Lost_souls on 16/6/29.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "LockViewController.h"
#import "LSCustomSlider.h"


@interface LockViewController ()<LSCustomSliderDelegate>

@property (strong,nonatomic) LSCustomSlider *slider;

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSliderView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSliderView {
    
    self.slider = [[LSCustomSlider alloc] initWithFrame:CGRectMake(100, 200, DEVICE_WIDTH - 100, 56)];
    [self.slider setBackgroundColor:[UIColor grayColor] foreground:[UIColor yellowColor] handle:[UIColor whiteColor] border:[UIColor groupTableViewBackgroundColor]];
    self.slider.layer.cornerRadius = self.slider.frame.size.height / 2.f;
    self.slider.thumbImage = [UIImage imageNamed:@"slide_img_thumb"];
    self.slider.backgroundImage = [UIImage imageNamed:@"slider_img_bg"];
//    self.slider.centerViewImage1 = [UIImage imageNamed:@"bg_center_imgv1"];
//    self.slider.centerViewImage2 = [UIImage imageNamed:@"bg_center_imgv2"];

    self.slider.delegate = self;
    self.slider.text = @"滑动打开柜门";
    self.slider.textFont = [UIFont systemFontOfSize:16.f];
    self.slider.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.slider];
}


- (void)slider:(LSCustomSlider *)slider valueChanged:(CGFloat)value {

}

- (void)sliderValueChangeEnd:(LSCustomSlider *)slider {
}

@end
