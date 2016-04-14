//
//  FoodDetailTableViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/8.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "FoodDetailTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FoodDetailTableViewController ()
{
    UIImageView *_imageView;
}

@end

@implementation FoodDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addHeaderView];
    [self getFoodDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addHeaderView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT *.4)];
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT *.4)];
    imgv.image = [UIImage imageNamed:@"placeholder"];
    _imageView = imgv;
    [view addSubview:imgv];
    
    self.tableView.tableHeaderView = view;
    
}

- (void)getFoodDetail {
    
    if (!self.foodId) {
        NSLog(@"...........self.foodId = nil");
        return;
    }
    
    [HttpRequestObj foodsDetailWithId:self.foodId showSVP:YES result:^(NSDictionary *result, NSError *error) {
        //
        if (!error) {
            NSLog(@"result == %@",result);
            if ([result[@"status"] integerValue]) {
                NSArray *tngou = result[@"tngou"];
                if (tngou.count == 0 || [tngou isEqual:[NSNull null]]) {
                    //self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
                
                NSURL *url = [NSURL URLWithString:kFOOD_URL_IMAGE_WH(result[@"img"], DEVICE_WIDTH, DEVICE_HEIGHT *.4)];
//                NSURL *url = [NSURL URLWithString:kFOOD_URL_IMAGE(result[@"img"])];

//                [self.foodsListArray addObject:model];
                dispatch_main(^{
                    [_imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached];
//                    [self.tableView.mj_header endRefreshing];
                    [self.tableView reloadData];
//                    [self.tableView.mj_footer endRefreshing];
                });
            }
            
        }else {
            NSLog(@"error == %@",error);
            dispatch_main(^{
//                [self.tableView.mj_header endRefreshing];
                [self.tableView reloadData];
//                [self.tableView.mj_footer endRefreshing];
            });
        }
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

@end
