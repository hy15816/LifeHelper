//
//  SharesTableViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/11.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "SharesTableViewController.h"
#import "SharesCell.h"
#import "SharesDetailViewController.h"


@interface SharesTableViewController ()
{
    NSMutableArray *_stocketListArray;
}
@end

@implementation SharesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _stocketListArray = [[NSMutableArray alloc] init];
//    [GlobalTool localClearFileCache];
    [self getCah];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _stocketListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SharesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SharesCellID" forIndexPath:indexPath];
    cell.sharesModel = _stocketListArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SharesDetailViewController *detail = kStoryboardShares(@"SharesDetailViewController");
    detail.shares = _stocketListArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)getScoketList {
    
    [HttpRequestObj sharesGetStockListWithPageNum:1 pageSize:20 showSVP:YES result:^(NSDictionary *result, NSError *error) {
        //
        if (!error) {
            NNLog(@"result == %@",result);

            if ([result[@"success"] integerValue] == 1) {
                NSArray *tngou = result[@"rows"];
                //保存到本地
                BOOL save = [GlobalTool localSaveDatas:[[NSMutableArray alloc] initWithArray:tngou] name:kSharesFileName];
                if (!save) {
                    NNLog(@"save failed !");
                }
                if (tngou.count) {
                    [_stocketListArray removeAllObjects];
                }
                for (NSDictionary *dic in tngou) {
                    SharesModel *model = [SharesModel model:dic];
                    [_stocketListArray addObject:model];
                }
                dispatch_main(^{
                    [self.tableView reloadData];
                });
            }
            
        }else {
            NNLog(@"error == %@",error);
        }
    }];
    
    /**
     *   area = "\U6c5f\U82cf";             //地区
         bvps = "3.18";                     //每股净挣
         code = 000584;                     //代码
         eps = "0.06900000000000001";       //每股收益
         fixedassets = "102501.96";         //固定资产
         industry = "\U5316\U7ea4";         //所属行业
         liquidassets = "205334.13";        //流动资产
         name = "\U53cb\U5229\U63a7\U80a1"; //名称
         outstanding = "61061.48";          //流通股本
         pb = "3.04";                       //市净率
         pe = "69.62";                      //市盈利
         reserved = "67523.72";             //公积金
         reservedpershare = "1.1";          //每股公积金
         timetomarket = "1995-11-28 00:00:00";// 上市日期
         totalassets = "318831.97";         //总资产(w)
         totals = "61332.42";               //总股本(w)
     */
    
}

- (void)getCah {
    
    // 获取本地缓存的数据
    NSArray *list = [GlobalTool localAllData:kSharesFileName];
    for (NSDictionary *dic in list) {
        SharesModel *model = [SharesModel model:dic];
        [_stocketListArray addObject:model];
    }
    [self.tableView reloadData];
    
    NNLog(@"[GlobalTool sharesAllData]:%@",list) ;
    
    // 获取网络数据-->刷新
//    [self getScoketList];
}

@end
