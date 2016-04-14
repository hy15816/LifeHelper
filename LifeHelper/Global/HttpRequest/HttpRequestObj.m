//
//  HttpRequestObj.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//



#import "HttpRequestObj.h"
#import "HttpRequestURL.h"
#import "NSString+MD5.h"

@interface HttpRequestObj ()
{
    NSString *_apiKey;
    NSString *_turingKey_bd;
    NSString *_turingKey_tr;
    NSString *_userid;
    
}
@end

@implementation HttpRequestObj

#pragma mark - ------------
+ (HttpRequestObj *)reqObj {
    
    static HttpRequestObj *reqObjs = nil;
    @synchronized (self) {
        if (reqObjs == nil) {
            reqObjs = [[HttpRequestObj alloc] init];
        }
    }
    
    return reqObjs;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        //
        _apiKey = @"1c3c8d653cadc0ce7bbd7d0b7649735b";
        _turingKey_bd = @"879a6cb3afb84dbf4fc84a1df2ab7319";   //
        _userid = @"eb2edb736"; //用户id
        _turingKey_tr = @"312a3e41afb014ebe81c901b2105bbc7";
    }
    
    return self;
}

#pragma mark - ----------

+ (void)formatString:(NSString *)str {
    
}

+ (void)formatStringWith:(NSString *)string {
    
}

+ (void)getIndexAllItemsShowSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] getIndexAllItemsShowSVP:show result:block];
}

+ (void)getCurrentUserInfoShowSVP:(BOOL)show result:(HttpRequestCallBack)block; {
    [[HttpRequestObj reqObj] getCurrentUserInfoShowSVP:show result:block];
}

+ (void)getAllCityList:(BOOL)showSVP result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] getAllCityList:showSVP result:block];
}

+ (void)getNumberOfAttributionShowSVP:(BOOL)show phoneNum:(NSString *)phoneNum result:(HttpRequestCallBack)block; {
    [[HttpRequestObj reqObj] getNumberOfAttributionShowSVP:show phoneNum:phoneNum result:block];
}

+ (void)getExpressInfoWithShowSVP:(BOOL)show orderNum:(NSString *)orderNum result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] getExpressInfoWithShowSVP:show orderNum:orderNum result:block];
}

+ (void)getWeatherInfoWithTwelveDays:(NSString *)cityName cityid:(NSString *)cityId showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] getWeatherInfoWithTwelveDays:cityName cityid:cityId showSVP:show result:block];
}

+ (void)getWeatherInfoWithCode:(NSString *)cityCode showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] getWeatherInfoWithCode:cityCode showSVP:show result:block];
}

+ (void)getCityInfo:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] getCityInfo:cityName showSVP:show result:block];
}

+ (void)getCityListAvailable:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] getCityListAvailable:cityName showSVP:show result:block];
}

+ (void)getWeatherInfoWithPinYin:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] getWeatherInfoWithPinYin:cityName showSVP:show result:block];
}

+ (void)getWeatherInfoWithChinase:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] getWeatherInfoWithChinase:cityName showSVP:show result:block];
}

+ (void)turingWithInput:(NSString *)inputString showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] turingWithInput:inputString showSVP:show result:block];
}

+ (void)rechargeCheckPermissionWithPrice:(NSString *)price phone:(NSString *)phoneNum showSVP:(BOOL)show result:(HttpRequestCallBack)block{
    [[HttpRequestObj reqObj] rechargeCheckPermissionWithPrice:price phone:phoneNum showSVP:show result:block];
}

/**
 *  Code 为0 表示请求成功 其他为失败
    Msg 表示请求成功或者失败信息
    Data：
    Cardid： 商品编号
    Cardname： 商品名称
    Inprice： 商品价格
    GameArea： 商品归属地
 
 Code说明：
 Code=0：可以充值；
 Code=11：运营商地区维护，暂不能充值
 Code=321：暂时不支持此类号码的充值
 Code=319：充值的号码格式不正确
 */
+ (void)rechargeGetGoodsInfoWithPrice:(NSString *)price phone:(NSString *)phoneNum showSVP:(BOOL)show result:(HttpRequestCallBack)block{
    [[HttpRequestObj reqObj] rechargeGetGoodsInfoWithPrice:price phone:phoneNum showSVP:show result:block];
}

+ (void)rechargeGetOrderListWithPhone:(NSString *)phoneNum pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize orderId:(NSString *)orderId showSVP:(BOOL)show result:(HttpRequestCallBack)block{
    [[HttpRequestObj reqObj] rechargeGetOrderListWithPhone:phoneNum pageNum:pageNum pageSize:pageSize orderId:orderId showSVP:show result:block];
}

+ (void)rechargeGetOrderStateWithId:(NSString *)orderId showSVP:(BOOL)show result:(HttpRequestCallBack)block{
    [[HttpRequestObj reqObj] rechargeGetOrderStateWithId:orderId showSVP:show result:block];
}

+ (void)rechargeGetUserBalanceWithShowSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] rechargeGetUserBalanceWithShowSVP:show result:block];
}
+ (void)rechargeWithPhone:(NSString *)phoneNum price:(NSString *)price orderId:(NSString *)orderId callBackURL:(NSString *)callBackurl showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] rechargeWithPhone:phoneNum price:price orderId:orderId callBackURL:callBackurl showSVP:show result:block];
}

+ (void)foodsMenuCategoryWithId:(NSString *)categoryId showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    [[HttpRequestObj reqObj] foodsMenuCategoryWithId:categoryId showSVP:show result:block];
}

+(void)foodsMenuListWithId:(NSString *)categoryId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] foodsMenuListWithId:categoryId pageNum:pageNum pageSize:pageSize showSVP:show result:block];
}

+(void)foodsDetailWithId:(NSString *)menuId showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    [[HttpRequestObj reqObj] foodsDetailWithId:menuId showSVP:show result:block];
}
+(void)foodWithName:(NSString *)foodName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    [[HttpRequestObj reqObj] foodWithName:foodName showSVP:show result:block];
}

+ (void)sharesGetStockListWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] sharesGetStockListWithPageNum:pageNum pageSize:pageSize showSVP:show result:block];
}

+ (void)sharesSearchWithCode:(NSArray *)sharesCodeArr name:(NSString *)sharesName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [[HttpRequestObj reqObj] sharesSearchWithCode:sharesCodeArr name:sharesName showSVP:show result:block];
}

#pragma mark - private method

- (void)getIndexAllItemsShowSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
}

- (void)getCurrentUserInfoShowSVP:(BOOL)show result:(HttpRequestCallBack)block; {
    
}

- (void)getAllCityList:(BOOL)showSVP result:(HttpRequestCallBack)block;{
    
}

- (void)getNumberOfAttributionShowSVP:(BOOL)show phoneNum:(NSString *)phoneNum result:(HttpRequestCallBack)block; {
    
    [self reqGETWithURL:[NSString stringWithFormat:@"%@?phone=%@",kURLGetPhoneAttributionInfo,phoneNum] paramter:phoneNum showSVP:show result:block];
}

- (void)getExpressInfoWithShowSVP:(BOOL)show orderNum:(NSString *)orderNum result:(HttpRequestCallBack)block {
    
}






#pragma mark - weather

- (void)getWeatherInfoWithTwelveDays:(NSString *)cityName cityid:(NSString *)cityId showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    NSString *url = [NSString stringWithFormat:@"%@?cityname=%@&cityid=%@",kURLGetWeatherInfoWithTwelveDays,[cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],cityId];
    
    //NSString *cityNameString = [cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    //ios 7+
    //NSString *cityNameString = [cityName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self reqGETWithURL:url paramter:nil showSVP:show result:block];
    
}
- (void)getWeatherInfoWithCode:(NSString *)cityCode showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    [self reqGETWithURL:[NSString stringWithFormat:@"%@?cityid=%@",kURLGetWeatherInfoWithCode,cityCode] paramter:nil showSVP:show result:block];
}

/**
 errNum = 0;
 retData =     {
 cityCode = 101010100;
 cityName = "\U5317\U4eac";
 provinceName = "\U5317\U4eac";
 telAreaCode = 010;
 zipCode = 100000;
 };
 retMsg = success;
 */
- (void)getCityInfo:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    NSString *urlString = [NSString stringWithFormat:@"%@?cityname=%@",kURLGetWeatherCityInfo,[cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [self reqGETWithURL:urlString paramter:nil showSVP:show result:block];
}

- (void)getCityListAvailable:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    NSString *urlString = [NSString stringWithFormat:@"%@?cityname=%@",kURLGetWeatherCityListAvailable,[cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self reqGETWithURL:urlString paramter:nil showSVP:show result:block];
}

- (void)getWeatherInfoWithPinYin:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    NSString *pinyin = [GlobalTool turnPinYinWithHanZi:cityName];
    NSString *urlString = [NSString stringWithFormat:@"%@?citypinyin=%@",kURLGetWeatherInfoWithPinYin,pinyin];
    
    [self reqGETWithURL:urlString paramter:nil showSVP:show result:block];
}

/**
 
 {
 errNum: 0,
 errMsg: "success",
 retData:   {
         city: "北京", //城市
         pinyin: "beijing", //城市拼音
         citycode: "101010100",  //城市编码
         date: "16-03-23", //日期
         time: "11:00", //发布时间
         postCode: "100000", //邮编
         longitude: 116.391, //经度
         latitude: 39.904, //维度
         altitude: "33", //海拔
         weather: "晴",  //天气情况
         temp: "10", //气温
         l_tmp: "-4", //最低气温
         h_tmp: "10", //最高气温
         WD: "无持续风向",	 //风向
         WS: "微风(<10m/h)", //风力
         sunrise: "07:12", //日出时间
         sunset: "17:44" //日落时间
     }
 }
*/
- (void)getWeatherInfoWithChinase:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    NSString *urlString = [NSString stringWithFormat:@"%@?cityname=%@",kURLGetWeatherInfoWithChinase,[cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [self reqGETWithURL:urlString paramter:nil showSVP:show result:block];
    
}









#pragma mark - turing

- (void)turingWithInput:(NSString *)inputString showSVP:(BOOL)show result:(HttpRequestCallBack)block {

    NSString *url = [NSString stringWithFormat:@"%@?key=%@&info=%@&userid=%@",kURLTuring_Turing,_turingKey_tr,[inputString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_userid];
    [self reqGETWithURL:url paramter:nil showSVP:show result:block];
    
}

#pragma mark - 话费充值
- (void)rechargeCheckPermissionWithPrice:(NSString *)price phone:(NSString *)phoneNum showSVP:(BOOL)show result:(HttpRequestCallBack)block{
    /**
     *  http://www.apix.cn/services/show/110
     */
    NSString *url = [NSString stringWithFormat:@"%@?phone=%@&price=%@",kURLRechargeCheckPermission,phoneNum,price];
    [self reqGETWithURL:url apikey:kAPIX_APIKEY showSVP:show result:block];
}

- (void)rechargeGetGoodsInfoWithPrice:(NSString *)price phone:(NSString *)phoneNum showSVP:(BOOL)show result:(HttpRequestCallBack)block{
    
    NSString *url = [NSString stringWithFormat:@"%@?phone=%@&price=%@",kURLRechargeGetGoodsInfo,phoneNum,price];
    [self reqGETWithURL:url apikey:kAPIX_APIKEY showSVP:show result:block];
}

- (void)rechargeGetOrderListWithPhone:(NSString *)phoneNum pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize orderId:(NSString *)orderId showSVP:(BOOL)show result:(HttpRequestCallBack)block{
    
    NSString *url = [NSString stringWithFormat:@"%@?page=%ld&page_size=%ld&phone=%@&orderid=%@",kURLRechargeOrderList,(long)pageNum,(long)pageSize,phoneNum,orderId];
    [self reqGETWithURL:url apikey:kAPIX_APIKEY showSVP:show result:block];
}
- (void)rechargeGetOrderStateWithId:(NSString *)orderId showSVP:(BOOL)show result:(HttpRequestCallBack)block{
    
    [self reqGETWithURL:[NSString stringWithFormat:@"%@?orderid=%@",kURLRechargeOrderState,orderId] apikey:kAPIX_APIKEY showSVP:show result:block];

}

- (void)rechargeGetUserBalanceWithShowSVP:(BOOL)show result:(HttpRequestCallBack)block; {
    [self reqGETWithURL:kURLApixUserBalance apikey:kAPIX_APIKEY showSVP:show result:block];
}
- (void)rechargeWithPhone:(NSString *)phoneNum price:(NSString *)price orderId:(NSString *)orderId callBackURL:(NSString *)callBackurl showSVP:(BOOL)show result:(HttpRequestCallBack)block{
    
    NSString *signString = [NSString stringWithFormat:@"%@%@%@",phoneNum,price,orderId];
    NSString *urlString = [NSString stringWithFormat:@"%@?phone=%@&price=%@&orderid=%@&sign=%@&callback_url=%@",kURLRechargeWithPhone,phoneNum,price,orderId,[signString stringWithMD5],callBackurl];
    [self reqGETWithURL:urlString apikey:kAPIX_APIKEY showSVP:show result:block];
    
}

#pragma mark - foods
- (void)foodsMenuCategoryWithId:(NSString *)categoryId showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@",kURLFoodsMenuCategory,categoryId];
    [self reqGETWithURL:urlString paramter:nil showSVP:show result:block];
}

- (void)foodsMenuListWithId:(NSString *)categoryId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&page=%ld&rows=%ld",kURLFoodsMenuList,categoryId,(long)pageNum,(long)pageSize];
    [self reqGETWithURL:urlString paramter:nil showSVP:show result:block];
}

- (void)foodsDetailWithId:(NSString *)menuId showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@",kURLFoodsDetail,menuId];
    [self reqGETWithURL:urlString paramter:nil showSVP:show result:block];
}

- (void)foodWithName:(NSString *)foodName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    NSString *urlString = [NSString stringWithFormat:@"%@?name=%@",kURLFoodWithName,[foodName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self reqGETWithURL:urlString paramter:nil showSVP:show result:block];
}

#pragma mark - shares
- (void)sharesGetStockListWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    NSString *urlString = [NSString stringWithFormat:@"%@?page=%ld&rows=%ld",kURLSharesScoketList,(long)pageNum,(long)pageSize];
    [self reqGETWithURL:urlString paramter:nil showSVP:show result:block];
}

- (void)sharesSearchWithCode:(NSArray *)sharesCodeArr name:(NSString *)sharesName showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    if (![sharesCodeArr isKindOfClass:[NSArray class]] || sharesCodeArr.count <= 0  ) {
        if (block) {
            NSError *error = [NSError errorWithDomain:@"1235" code:-99 userInfo:@{NSLocalizedDescriptionKey:@"Please enter shares code at least one with array"}];
            block(nil,error);
        }
        
        return;
    }
    NSString *code = @"";
    if (sharesCodeArr.count == 1) {
        code = [sharesCodeArr firstObject];
    }else if (sharesCodeArr.count > 1) {
        code = [sharesCodeArr firstObject];
        for (int i=1; i<sharesCodeArr.count; i++) {
            code = [NSString stringWithFormat:@"%@,%@",code,sharesCodeArr[i]];
        }
    }
    NSLog(@"sharesCode----------- %@",code);
    NSString *urlString = [NSString stringWithFormat:@"%@?stockid=%@&list=%lu",kURLSharesSearchs,code,(unsigned long)sharesCodeArr.count];
    [self reqGETWithURL:urlString paramter:nil showSVP:show result:block];
    // stockid 股票ID，最多查询10支股票代码，多于10支则查前10支，股票代码请自行查阅股市大盘，如果list=1，则可以查询多支股票，用逗号（,）隔开
    // list    是否一次查询多值股票。list=1:一次查询多支股票，list=其它，则一次查询一直股票
}


#pragma mark - Http Request

- (void)reqPOSTWithURL:(NSString *)urlString paramter:(id)paramter{
    
}
/**
 *  使用baidu的key
 *
 *  @param urlString <#urlString description#>
 *  @param paramter  <#paramter description#>
 *  @param show      <#show description#>
 *  @param block     <#block description#>
 */
- (void)reqGETWithURL:(NSString *)urlString paramter:(id)paramter showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    if (show) {
        dispatch_main(^{
//            [SVProgressHUD setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [SVProgressHUD showWithStatus:@""];
        });
    }
//    NSString *par = [(NSString *)paramter stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"urlString:%@",urlString);
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@", urlString];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: _apiKey forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
        
           if (error) {
               dispatch_main(^{
                   [SVProgressHUD dismiss];
               });
               NSLog(@"Http error: %@%ld", error.localizedDescription, (long)error.code);
               if (block) {
                   block(nil,error);
               }
               
           } else {
               NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//               NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
               NSLog(@"HttpResponseCode:%ld", (long)responseCode);
//               NSLog(@"HttpResponseBody %@",responseString);
               
               NSError *jsonError;
               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
               dispatch_main(^{
                   [SVProgressHUD dismiss];
               });
               if (jsonError) {
                   if (block) {
                       block(nil,jsonError);
                   }
               }else {
                   if (block) {
                       block(dict,nil);
                   }
               }
           }
    }];
}


- (void)reqGETWithURL:(NSString *)urlString apikey:(NSString *)serviceApiKey showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": serviceApiKey };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if (error.code == -1001) {
                NSLog(@"请求超时,请检查网络");
            }
            NSLog(@"%@", error);
            if (block) {
                block(nil,error);
            }
        } else {
            NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            if (responseCode == 200) {
                NSError *jsonError;
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
                if (block) {
                    block(dict,nil);
                }
            }
            
        }
    }];
    [dataTask resume];
}

- (void)reqPOSTWithURL:(NSString *)urlString paramter:(id)paramter showSVP:(BOOL)show result:(HttpRequestCallBack)block {
    
    if (show) {
        dispatch_main(^{
            
        });
    }
    NSLog(@"urlString:%@......paramter:%@",urlString,paramter);
//    NSString *par = [(NSString *)paramter stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@%@", urlString, par];
    NSURL *url = [NSURL URLWithString: urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod: @"POST"];
    NSError *dataError = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:paramter options:0 error:&dataError];
    [request setHTTPBody:data];
    if (dataError) {
        NSLog(@"dataError:%@",dataError);
        return;
    }
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        if (error) {
            NSLog(@"Http error: %@%ld", error.localizedDescription, error.code);
            if (block) {
                block(nil,error);
            }else {
                NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"HttpResponseCode:%ld", responseCode);
                NSLog(@"HttpResponseBody %@",responseString);
                
                NSError *jsonError;
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
                if (jsonError) {
                    if (block) {
                        block(nil,jsonError);
                    }
                }else {
                    if (block) {
                        block(dict,nil);
                    }
                }
            }
            
        }
    }];
    
    [task resume];
}


/**
 *  检测网络
 *
 *  @param block 返回结果
 */
- (void)checkWlanState:(void (^)(BOOL has))block {
    
    
    
}


@end
