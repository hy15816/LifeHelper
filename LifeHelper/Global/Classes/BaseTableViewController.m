//
//  BaseTableViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#define kViewsAnimationDuration  0.25f

#import "BaseTableViewController.h"

@interface BaseTableViewController ()
{
    CGFloat _tipsLabelY;
    CGFloat _scroToTopY;
}

/** 显示 当前页/总页数 */
@property (strong,nonatomic) UILabel *tipsLabel;
/** 返回顶部 */
@property (strong,nonatomic) UIButton *scrollerToTop;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.view addSubview:self.tipsLabel];
    [self.view bringSubviewToFront:self.tipsLabel];

    [self.view addSubview:self.scrollerToTop];
    [self.view bringSubviewToFront:self.scrollerToTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTipsText:(NSString *)text animation:(BOOL)animation {
    
    
    if (!animation) {
        self.tipsLabel.text = text;
        self.tipsLabel.alpha = 1.0f;
        return;
    }
    [UIView animateWithDuration:kViewsAnimationDuration animations:^{
        //
        if (self.canShowTipsLabel) {
            self.tipsLabel.text = text;
            self.tipsLabel.alpha = 1.0f;
        }
        
    }];
    
}


- (void)scrollerToTopAction {
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
};



//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 固定位置
    self.tipsLabel.frame = CGRectMake(self.tipsLabel.frame.origin.x, _tipsLabelY + self.tableView.contentOffset.y , self.tipsLabel.frame.size.width, self.tipsLabel.frame.size.height);
    
    self.scrollerToTop.frame = CGRectMake(self.scrollerToTop.frame.origin.x, _scroToTopY + self.tableView.contentOffset.y , self.scrollerToTop.frame.size.width, self.scrollerToTop.frame.size.height);
    if (scrollView.contentOffset.y > DEVICE_HEIGHT) {
        self.scrollerToTop.hidden = NO;
    }else {
        self.scrollerToTop.hidden = YES;
        self.tipsLabel.alpha = 0.0f;
    }
}

// 拖动的时候 && 长度已经超过一个屏幕的高度 --> 显示tips
// 停止拖动时隐藏

//开始拖动，
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"scrollView.contentOffset.y:%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > self.tableView.frame.size.height) {
        if (self.canShowTipsLabel) {
            [self showTipsLabel];
        }
        
    }
    
}
//拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y > self.tableView.contentSize.height) {
        
    }
    
    [self hideTipsLabel];
}

- (void)showTipsLabel {
    
    [UIView animateWithDuration:kViewsAnimationDuration animations:^{
        //
        self.tipsLabel.alpha = 1.0f;
    }];
}

- (void)hideTipsLabel {
    
    [UIView animateWithDuration:kViewsAnimationDuration animations:^{
        //
        self.tipsLabel.alpha = 0.0f;
    }];
    
}


- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake((DEVICE_WIDTH - 80)/2, DEVICE_HEIGHT-30, 80, 15)];
        _tipsLabel.layer.cornerRadius = 10;
        _tipsLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tipsLabel.font = [UIFont systemFontOfSize:12];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.alpha = 0.0f;
        _tipsLabel.layer.masksToBounds = YES;

        _tipsLabelY = _tipsLabel.frame.origin.y;
        
    }
    
    return _tipsLabel;
}


- (UIButton *)scrollerToTop {
    CGFloat margin = 50;
    if (!_scrollerToTop) {
        _scrollerToTop = [UIButton buttonWithType:UIButtonTypeCustom];
        _scrollerToTop.frame = CGRectMake(DEVICE_WIDTH - margin, DEVICE_HEIGHT - margin, DEVICE_WIDTH *.1f, DEVICE_WIDTH *.1f);
        _scrollerToTop.layer.cornerRadius = DEVICE_WIDTH *.1f *.5;
        _scrollerToTop.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _scrollerToTop.layer.borderWidth = 0.5f;
        [_scrollerToTop setImage:[UIImage imageNamed:@"7"] forState:UIControlStateNormal];
        _scrollerToTop.hidden = YES;
        [_scrollerToTop addTarget:self action:@selector(scrollerToTopAction) forControlEvents:UIControlEventTouchUpInside];
        
        _scroToTopY = _scrollerToTop.frame.origin.y;
    }
    
    return _scrollerToTop;
}

@end
