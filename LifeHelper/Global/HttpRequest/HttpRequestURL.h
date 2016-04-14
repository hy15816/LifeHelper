//
//  HttpRequestURL.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#define HTTPURL_EXTERN extern __attribute__((visibility ("default")))

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const kBMKMAP_APP_KEY;

/**
 *  获取手机归属地
 */
UIKIT_EXTERN NSString *const kURLGetPhoneAttributionInfo;

/**
 *  获取所有省列表
 */
UIKIT_EXTERN NSString *const kURLGetAllCityList;

/**
 *  查询可用城市列表
 */
UIKIT_EXTERN NSString *const kURLGetWeatherCityListAvailable;
/**
 *  城市信息列表
 */
UIKIT_EXTERN NSString *const kURLGetWeatherCityInfo;
/**
 *  天气查询 - 前7天后4天
 */
UIKIT_EXTERN NSString *const kURLGetWeatherInfoWithTwelveDays;
/**
 *  天气查询 - 城市名(拼音)
 */
UIKIT_EXTERN NSString *const kURLGetWeatherInfoWithPinYin;
/**
 *  天气查询 - 城市名(中文)
 */
UIKIT_EXTERN NSString *const kURLGetWeatherInfoWithChinase;
/**
 *  天气查询 - cityCode
 */
UIKIT_EXTERN NSString *const kURLGetWeatherInfoWithCode;

/**
 *  图灵——baidu
 */
UIKIT_EXTERN NSString *const kURLTuring_Baidu;
/**
 *  图灵——turing
 */
UIKIT_EXTERN NSString *const kURLTuring_Turing;

/**
 *  APIKEY
 */
UIKIT_EXTERN NSString *const kAPIX_APIKEY;

/**
 *  apix-话费充值—历史订单list
 */
UIKIT_EXTERN NSString *const kURLRechargeOrderList;

/**
 *  apix-话费充值—账户余额
 */
UIKIT_EXTERN NSString *const kURLApixUserBalance;

/**
 *  apix-话费充值—订单状态查询
 */
UIKIT_EXTERN NSString *const kURLRechargeOrderState;

/**
 *  apix-话费充值—手机充值
 */
UIKIT_EXTERN NSString *const kURLRechargeWithPhone;

/**
 *  apix-话费充值—根据手机号和充值额度查询商品信息
 */
UIKIT_EXTERN NSString *const kURLRechargeGetGoodsInfo;
/**
 *  apix-话费充值—根据手机号码和金额查询能否充值
 */
UIKIT_EXTERN NSString *const kURLRechargeCheckPermission;


/**
 *  菜谱分类
 */
HTTPURL_EXTERN NSString *const kURLFoodsMenuCategory;

/**
 *  菜谱列表
 */
HTTPURL_EXTERN NSString *const kURLFoodsMenuList;

/**
 *  菜谱详情
 */
HTTPURL_EXTERN NSString *const kURLFoodsDetail;

/**
 *  菜谱做法
 */
HTTPURL_EXTERN NSString *const kURLFoodWithName;

HTTPURL_EXTERN NSString *const kURLSharesScoketList;

HTTPURL_EXTERN NSString *const kURLSharesSearchs;

