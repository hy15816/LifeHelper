//
//  HttpRequestObj.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SVProgressHUD.h"
#import <SVProgressHUD/SVProgressHUD.h>

/**
 *  回调
 *
 *  @param result 正确的返回
 *  @param error  返回错误信息
 */
typedef void (^HttpRequestCallBack)(NSDictionary *result,NSError *error);


@interface HttpRequestObj : NSObject

// 弃用方法
+ (void)formatString:(NSString *)str NS_DEPRECATED(10_0, 10_11, 2_0, 8_0, "Use -formatStringWith: instead, which always uses the string formate.");
// 启用方法
+ (void)formatStringWith:(NSString *)string NS_AVAILABLE(10_9, 7_0);

+ (void)getIndexAllItemsShowSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  获取用户信息
 *
 *  @param show  是否显示SVP
 *  @param block @see HttpRequestCallBack
 */
+ (void)getCurrentUserInfoShowSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  获取号码归属地信息
 *
 *  @param show  是否显示SVP
 *  @param block @see HttpRequestCallBack
 */
+ (void)getNumberOfAttributionShowSVP:(BOOL)show phoneNum:(NSString *)phoneNum result:(HttpRequestCallBack)block;

/**
 *  获取快递信息
 *
 *  @param show  是否显示SVP
 *  @param block @see HttpRequestCallBack
 */
+ (void)getExpressInfoWithShowSVP:(BOOL)show orderNum:(NSString *)orderNum result:(HttpRequestCallBack)block;

#pragma mark - 天气

/**
 *  获取全国所有城市列表
 *
 *  @param showSVP 是否显示SVP
 *  @param block   @see HttpRequestCallBack
 */
+ (void)getAllCityList:(BOOL)showSVP result:(HttpRequestCallBack)block;

/**
 *  查询可用城市列表
 *
 *  @param cityName 城市名
 *  @param show  是否显示SVP
 *  @param block @see HttpRequestCallBack
 */
+ (void)getCityListAvailable:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block;


/**
 *  城市信息列表(包括:cityName,provinceName-省份,cityCode-天气预报城市代码,zipCode-邮编,telAreaCode-电话区号)
 *
 *  @param cityName 城市名
 *  @param show  是否显示SVP
 *  @param block @see HttpRequestCallBack
 */
+ (void)getCityInfo:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  天气查询 -- 包括历史7天和未来4天
 *
 *  @param cityName 城市名
 *  @param cityId   城市名
 *  @param show     是否显示SVP
 *  @param block    @see HttpRequestCallBack
 */
+ (void)getWeatherInfoWithTwelveDays:(NSString *)cityName cityid:(NSString *)cityId showSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  天气查询 -- 根据城市拼音
 *
 *  @param cityName 城市(中文，在方法内部转换成拼音)
 *  @param show     是否显示SVP
 *  @param block    @see HttpRequestCallBack
 */
+ (void)getWeatherInfoWithPinYin:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  天气查询 -- 根据城市名称
 *
 *  @param cityName 城市(中文)
 *  @param show     是否显示SVP
 *  @param block    @see HttpRequestCallBack
 */
+ (void)getWeatherInfoWithChinase:(NSString *)cityName showSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  天气查询 -- 根据城市代码
 *
 *  @param cityName 城市代码(code)
 *  @param show     是否显示SVP
 *  @param block    @see HttpRequestCallBack
 */
+ (void)getWeatherInfoWithCode:(NSString *)cityCode showSVP:(BOOL)show result:(HttpRequestCallBack)block;


#pragma mark - 图灵机器人
/**
 *  图灵机器人
 *
 *  @param inputString 输入数据
 *  @param show        是否显示SVP
 *  @param block       @see HttpRequestCallBack
 */
+ (void)turingWithInput:(NSString *)inputString showSVP:(BOOL)show result:(HttpRequestCallBack)block;




#pragma mark - 话费充值
/**
 *  根据手机号码和金额查询能否充值
 *
 *  @param price    金额
 *  @param phoneNum 号码
 *  @param show     是否显示SVP
 *  @param block    @see HttpRequestCallBack
 */
+ (void)rechargeCheckPermissionWithPrice:(NSString *)price phone:(NSString *)phoneNum showSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  根据手机号码和价格获取商品
 *
 *  @param price    金额
 *  @param phoneNum 号码
 *  @param show     是否显示SVP
 *  @param block    @see HttpRequestCallBack
 */
+ (void)rechargeGetGoodsInfoWithPrice:(NSString *)price phone:(NSString *)phoneNum showSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  获取历史充值订单记录
 *
 *  @param phoneNum 手机号码
 *  @param pageNum  当前页数
 *  @param pageSize 每页条数
 *  @param orderId  订单号
 *  @param show     是否显示SVP
 *  @param block    @see HttpRequestCallBack
 */
+ (void)rechargeGetOrderListWithPhone:(NSString *)phoneNum pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize orderId:(NSString *)orderId showSVP:(BOOL)show result:(HttpRequestCallBack)block;
/**
 *  获取订单状态
 *
 *  @param orderId 订单号
 *  @param show    是否显示SVP
 *  @param block   @see HttpRequestCallBack
 */
+ (void)rechargeGetOrderStateWithId:(NSString *)orderId showSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  获取用户余额，apix账户
 *
 *  @param show  是否显示SVP
 *  @param block @see HttpRequestCallBack
 */
+ (void)rechargeGetUserBalanceWithShowSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  话费充值
 *
 *  @param phoneNum    手机号码
 *  @param price       充值金额
 *  @param orderId     订单号
 *  @param callBackurl 回调url
 *  @param show        是否显示SVP
 *  @param block       @see HttpRequestCallBack
 */
+ (void)rechargeWithPhone:(NSString *)phoneNum price:(NSString *)price orderId:(NSString *)orderId callBackURL:(NSString *)callBackurl showSVP:(BOOL)show result:(HttpRequestCallBack)block;



#pragma mark - 天狗健康菜谱
/**
 *  获取菜谱分类
 *
 *  @param categoryId 上级分类id
 *  @param show       是否显示SVP
 *  @param block      @see HttpRequestCallBack
 */
+ (void)foodsMenuCategoryWithId:(NSString *)categoryId showSVP:(BOOL)show result:(HttpRequestCallBack)block;


/**
 *  获取菜谱列表
 *
 *  @param categoryId 分类id
 *  @param pageNum    当前页数  df=1
 *  @param pageSize   每页条数  df=20
 *  @param show       是否显示SVP
 *  @param block      @see HttpRequestCallBack
 */
+ (void)foodsMenuListWithId:(NSString *)categoryId pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize showSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  获取菜谱详情
 *
 *  @param menuId     菜谱id
 *  @param show       是否显示SVP
 *  @param block      @see HttpRequestCallBack
 */
+ (void)foodsDetailWithId:(NSString *)menuId showSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  获取菜谱
 *
 *  @param foodName 菜的名称
 *  @param show     是否显示SVP
 *  @param block    @see HttpRequestCallBack
 */
+ (void)foodWithName:(NSString *)foodName showSVP:(BOOL)show result:(HttpRequestCallBack)block;

#pragma mark -   ====== shares


/**
 *  <#Description#>
 *
 *  @param pageNum    当前页数  df=1
 *  @param pageSize   每页条数  df=20
 *  @param show       是否显示SVP
 *  @param block      @see HttpRequestCallBack
 */
+ (void)sharesGetStockListWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize showSVP:(BOOL)show result:(HttpRequestCallBack)block;

/**
 *  <#Description#>
 *
 *  @param sharesCodeArr 代码数组
 *  @param sharesName 名称
 *  @param show       是否显示SVP
 *  @param block      @see HttpRequestCallBack
 */
+ (void)sharesSearchWithCode:(NSArray *)sharesCodeArr name:(NSString *)sharesName showSVP:(BOOL)show result:(HttpRequestCallBack)block;


















@end
















