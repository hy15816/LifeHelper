//
//  SharesDetailViewController.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/12.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "SharesDetailViewController.h"

@interface SharesDetailViewController ()

@end

@implementation SharesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getStockDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)getStockDetail {
    
    if (self.shares.sharesCode) {
        [HttpRequestObj sharesSearchWithCode:@[self.shares.sharesCode] name:nil showSVP:YES result:^(NSDictionary *result, NSError *error) {
            //
            if (!error) {
                NNLog(@"result == %@",result);
                //                if ([result[@"success"] integerValue] == 1) {
                ////                    NSArray *tngou = result[@"rows"];
                //
                //                    dispatch_main(^{
                //                        [self.tableView reloadData];
                //                    });
                //                }
                
            }else {
                NNLog(@"error == %@",error);
            }
        }];
    }else {
        NNLog(@"sharesCode == nil");
    }
    
}


/*
 result == {
 errMsg = success;
 errNum = 0;
 retData =     {
 market =         { //大盘指数
 
    DJI = {
        closedot = "17576.96";
        curdot = "17556.41";    // 当前价格
        date = "2016-04-12 07:30:07";
        growth = "-20.55";
        hdot = "17731.63";
        ldot = "17555.9";
        name = "\U9053\U743c\U65af";
        rate = "-0.12";
        startdot = "17586.48";
        turnover = 0;
     };
 
     HSI =             {
         52hdot = "28588.52";
         52ldot = "18278.8";
         closedot = "20440.81";
         curdot = "20493.73";
         date = "2016/04/12 15:58";
         growth = "52.92";
         hdot = "20546.43";
         ldot = "20407.82";
         name = "\U6052\U751f\U6307\U6570";
         rate = "0.26";
         startdot = "20440.72";
         turnover = 49526627;
     };
 
     INX =             {
         closedot = "2047.6";
         curdot = "2041.99";
         date = "2016-04-12 08:31:34";
         growth = "-5.61";
         hdot = "2062.93";
         ldot = "2041.88";
         name = "\U7eb3\U65af\U8fbe\U514b";
         rate = "-0.27";
         startdot = "2050.23";
         turnover = 0;
     };
 
     IXIC =             {
         closedot = "4850.69";
         curdot = "4833.4";
         date = "2016-04-12 08:31:34";
         growth = "-17.29";
         hdot = "4897.55";
         ldot = "4833.4";
         name = "\U7eb3\U65af\U8fbe\U514b";
         rate = "-0.36";
         startdot = "4873.39";
         turnover = 1515551844;
     };
 
     shanghai =             {
         curdot = "3023.6464";                  // 当前价格
         curprice = "-10.3106";                 //当前价格涨幅
         dealnumber = 1827186;                  //交易量，单位为手（一百股）
         name = "\U4e0a\U8bc1\U6307\U6570";     // 名称
         rate = "-0.34";                        // 涨幅率
         turnover = 20707981;                   //成交额，万元为单位
         };
 
     shenzhen =             {
         curdot = "10533.405";
         curprice = "-76.19";
         dealnumber = 217142978;
         name = "\U6df1\U8bc1\U6210\U6307";
         rate = "-0.72";
         turnover = 37533650;
         };
     };
 
 stockinfo =         (
 {
     name: "科大讯飞", //股票名称
     code: "sz002230", //股票代码，SZ指在深圳交易的股票
     date: "2014-09-22", //当前显示股票信息的日期
     time: "09:26:11",   //具体时间
     OpenningPrice: 27.34, //今日开盘价
     closingPrice: 27.34,  //昨日收盘价
     currentPrice: 27.34,  //当前价格
     hPrice: 27.34,        //今日最高价
     lPrice: 27.34,       //今日最低价
     competitivePrice: 27.30, //买一报价
     auctionPrice: 27.34,   //卖一报价
     totalNumber: 47800,    //成交的股票数
     turnover: 1306852.00,  //成交额，以元为单位
     increase: -1.6769959897922,//涨幅
     buyOne: 6100,      //买一
     buyOnePrice: 27.30, //买一价格
     buyTwo: 7500,  //买二
     buyTwoPrice: 27.29, //买二价格
     buyThree: 2000,   //买三
     buyThreePrice: 27.27,  //买三价格
     buyFour: 100,    //买四
     buyFourPrice: 27.25, //买四价格
     buyFive: 5700,     //买五
     buyFivePrice: 27.22,  //买五价格
     sellOne: 10150,       //卖一
     sellOnePrice: 27.34,  //卖一价格
     sellTwo: 15200,      //卖二
     sellTwoPrice: 27.35,  //卖二价格
     sellThree: 5914,     //卖三
     sellThreePrice: 27.36, //卖三价格
     sellFour: 400,        //卖四
     sellFourPrice: 27.37,  //卖四价格
     sellFive: 3000,       //卖五
     sellFivePrice: 27.38   //卖五价格
     minurl: "http://image.sinajs.cn/newchart/min/n/sz002230.gif", //分时K线图
     dayurl: "http://image.sinajs.cn/newchart/daily/n/sz002230.gif", //日K线图
     weekurl: "http://image.sinajs.cn/newchart/weekly/n/sz002230.gif", //周K线图
     monthurl: "http://image.sinajs.cn/newchart/monthly/n/sz002230.gif" //月K线图
     }
 );
 };
 }
*/

@end
