//
//  FoodListViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/7.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "FoodListViewController.h"
#import "FoodsListCell.h"
#import "FoodsListModel.h"
#import "MJRefresh.h"
#import "FoodDetailTableViewController.h"

@interface FoodListViewController ()
{
    NSInteger _pageNum;
    NSInteger _pageSize;
    NSInteger _total;
    CGFloat _lastScrollerOffsetY;
}
@property (strong,nonatomic) NSMutableArray *foodsListArray;
@end

@implementation FoodListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.canShowTipsLabel = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.canShowTipsLabel = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化默认加载条数
    _pageNum = 1;
    _pageSize = 20;
    
    // 下拉刷新数据
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        _pageNum = 1;
        [self getFoodList:YES page:_pageNum size:_pageSize];
    }];
    
    // 上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        _pageNum ++;
        // 总页数
        NSInteger pageCount = _total%_pageSize == 0?_total/_pageSize:_total/_pageSize+1;
        NSString *text = [NSString stringWithFormat:@"%ld/%ld",(long)_pageNum,(long)pageCount];
        [self setTipsText:text animation:YES];
        [self getFoodList:NO page:_pageNum size:_pageSize];
        
    }];
    
    // 第一次进入view
    [self getFoodList:YES page:_pageNum size:_pageSize];
}

- (void)getFoodList:(BOOL)isRef page:(NSInteger)page size:(NSInteger)size {
    
    if (!self.categoryId) {
        NSLog(@" self.categoryId = nil");
        return;
    }else {
        
        [HttpRequestObj foodsMenuListWithId:self.categoryId pageNum:page pageSize:size showSVP:NO result:^(NSDictionary *result, NSError *error) {
            //
            if (!error) {
                NSLog(@"result == %@",result);
                if ([result[@"status"] integerValue]) {
                    NSArray *tngou = result[@"tngou"];
                    if (tngou.count == 0 || [tngou isEqual:[NSNull null]]) {
                        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                    }
                    if (isRef) {
                        [self.foodsListArray removeAllObjects];
                    }
                    for (NSDictionary *dic in tngou) {
                        FoodsListModel *model = [FoodsListModel modelWithDic:dic];
                        [self.foodsListArray addObject:model];
                    }
                    
                    _total = [result[@"total"] intValue];
                    
                    dispatch_main(^{
                        
                        [self.tableView.mj_header endRefreshing];
                        [self.tableView reloadData];
                        [self.tableView.mj_footer endRefreshing];
                    });
                }
                
            }else {
                NSLog(@"error == %@",error);
                dispatch_main(^{
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView reloadData];
                    [self.tableView.mj_footer endRefreshing];
                });
            }
        }];
    }
    
    /**
     *  {
             count = 6773;      //访问数，浏览量
             description = "\U6750\U6599\U82b9\U83dc\U53f6\Uff0c\U9ed1\U6728\U8033\Uff0c\U767d\U829d\U9ebb\Uff08\U719f\Uff09\Uff0c\U76d0\Uff0c\U82b1\U6912\U6cb9\Uff0c\U9999\U6cb9\U505a\U6cd51\U3001\U82b9\U83dc\U53f6\U6d17\U51c0\Uff0c\U653e\U5165\U52a0\U4e86\U76d0\U7684\U6cb8\U6c34\U91cc\U8f7b\U712f\U4e00\U4e0b\Uff0c\U635e\U51fa\U6525\U5e72\U6c34\U5206\Uff0c\U5f04\U6210\U5c0f\U6bb5\Uff1b2\U3001\U5c06\U6ce1\U53d1\U597d\U7684\U9ed1\U6728\U8033\U5254\U9664\U6839\U90e8\Uff0c\U7528\U6e05\U6c34\U53cd\U590d\U51b2\U6d17\U5e72\U51c0\Uff0c\U7136\U540e\U8fc7\U6cb8\U6c34\U712f\U719f\Uff0c\U8fc7\U51c9\U6c34\U540e\U6ca5\U5e72\U6c34\U5206\Uff0c\U5207\U6210\U7ec6\U4e1d\Uff1b3\U3001\U5c06\U4e0a\U8ff0\U6750\U6599\U4e0e\U767d\U829d\U9ebb\U4e00\U8d77\U653e\U5165\U8c03\U7406\U76c6\Uff0c\U52a0\U5165\U9002\U91cf\U7684\U76d0\U3001\U82b1\U6912\U6cb9\U548c\U9999\U6cb9\Uff0c\U6df7\U5408\U5747\U5300\Uff0c\U6e0d\U4e0a\U7247\U523b\Uff0c\U5373\U53ef\U76db\U76d8\U98df\U7528\U4e86";
             fcount = 0;        //收藏数
             food = "\U82b9\U83dc\U53f6,\U9ed1\U6728\U8033,\U767d\U829d\U9ebb,\U82b1\U6912\U6cb9,\U9999\U6cb9";  // 相关食物
             id = 164;
             images = "";       //多张图片，由逗号隔开
             img = "/cook/150802/fc43c4736144faf2c52aed1965aa5a19.jpg";
             keywords = "\U9ed1\U6728\U8033 \U83dc\U53f6 \U82b1\U6912\U6cb9 \U767d\U829d\U9ebb \U6c34\U5206 ";  //关键词
             name = "\U82b9\U83dc\U53f6\U62cc\U6728\U8033";         //名称
             rcount = 0;        //评论数
         },
     *
     *
     */
    
    /**
     说明：img字段返回的是不完整的图片路径src，
     需要在前面添加【http://tnfs.tngou.net/image】或者【http://tnfs.tngou.net/img】
     前者可以在图片后面添加宽度和高度，如：http://tnfs.tngou.net/image/top/default.jpg_180x120
     *
     * 详情请参考：http://www.tngou.net/doc/cook     *
     */
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    [super scrollViewDidScroll:scrollView];
    // 向下拖动()时才在这里设置
    if (scrollView == self.tableView) {
        CGFloat y = scrollView.contentOffset.y;
        if (y > _lastScrollerOffsetY) {
            //用户往上拖动，
            //NSLog(@"y up :%f",y);
        } else {
            //NSLog(@"向下拖动");
            CGFloat cellHeight = 80;
            NSInteger index = scrollView.contentOffset.y / (_pageSize * cellHeight) + 1;
            //NSLog(@"..........idnex:%ld",(long)index);
            if (_pageNum > 1) {
                NSInteger pageCount = _total%_pageSize == 0?_total/_pageSize:_total/_pageSize+1;
                NSString *text = [NSString stringWithFormat:@"%ld/%ld",(long)index,(long)pageCount];
                [self setTipsText:text animation:YES];
            }
        }
        _lastScrollerOffsetY = y;
    }
}

//拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
    _lastScrollerOffsetY = scrollView.contentOffset.y;
    NSLog(@"_lastScrollerOffsetY:%f",_lastScrollerOffsetY);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.foodsListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodsListCell" forIndexPath:indexPath];
    cell.foodModel = self.foodsListArray[indexPath.row];
    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return [self.foodsListArray[indexPath.row] foodCellHeight];
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodDetailTableViewController *deatil = kStoryboardFoods(@"FoodDetailTableViewController");
    deatil.foodId = [self.foodsListArray[indexPath.row] foodId];
    [self.navigationController pushViewController:deatil animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollerToTopAction {
    
//    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [super scrollerToTopAction ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)foodsListArray {
    
    if (!_foodsListArray) {
        _foodsListArray = [[NSMutableArray alloc] init];
    }
    
    return _foodsListArray;
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
