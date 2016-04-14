//
//  GlobalTool.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Helper.h"
#import "LocalFileName.h"

//设备高度
#define DEVICE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//设备宽度
#define DEVICE_WIDTH ([UIScreen mainScreen].bounds.size.width)

//主线程中运行
#define dispatch_main(block) dispatch_async(dispatch_get_main_queue(), block);

//子线程中运行
#define dispatch_global(a,b,block)  dispatch_async(dispatch_get_global_queue(a, b), block);

//
#define kStoryboardIndex(vcID) [[UIStoryboard storyboardWithName:@"IndexStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:vcID];
#define kStoryboardFoods(vcID) [[UIStoryboard storyboardWithName:@"FoodsTableViewController" bundle:nil] instantiateViewControllerWithIdentifier:vcID];
#define kStoryboardShares(vcID) [[UIStoryboard storyboardWithName:@"SharesStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:vcID];


#define kIOS_7   [[UIDevice currentDevice].systemVersion floatValue] >= 7.0
#define kIOS_8   [[UIDevice currentDevice].systemVersion floatValue] >= 8.0
#define kIOS_9   [[UIDevice currentDevice].systemVersion floatValue] >= 9.0

// ============菜谱===================
#define kFOOD_URL_IMAGE(str) [NSString stringWithFormat:@"http://tnfs.tngou.net/img%@",str]
/**
 *  可以设定大小
 *
 *  @param str image url
 *  @param w   width
 *  @param h   height
 *
 *  @return 完整的image url string
 */
#define kFOOD_URL_IMAGE_WH(str,w,h) [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@_%.fx%.f",str,w,h]

// ===================================

@interface GlobalTool : NSObject


+ (NSString *)dateStringWithFormat:(NSString *)formate;
+ (NSString *)generateTradeNO;

+ (BOOL)isValidateMobile:(NSString *)mobile;

/**
 *  把汉字转成拼音，中间无空格，
 *
 *  @param hanziString 汉字
 *
 *  @return 拼音String
 */
+ (NSString *)turnPinYinWithHanZi:(NSString *)hanziString ;

#pragma mark - 本地文件操作
/**
 *  保存文件到本地
 *
 *  @param dic      NSDictionary 将要保存的dic
 *  @param fileName 文件名
 *
 *  @return save result:YES-suc,NO-fail
 */
+ (BOOL)localSaveData:(NSDictionary *)dic name:(NSString*)fileName;

/**
 *  保存文件到本地
 *
 *  @param arr      NSMutableArray 将要保存的数组
 *  @param fileName 文件名
 *
 *  @return save result:YES-suc,NO-fail
 */
+ (BOOL)localSaveDatas:(NSMutableArray *)arr name:(NSString*)fileName;

/**
 *  获取本地文件
 *
 *  @param fileName 文件名
 *
 *  @return NSArray
 */
+ (NSArray *)localAllData:(NSString*)fileName;

/**
 *  清除指定文件
 *
 *  @param fileName 文件名
 *
 *  @return result:YES-suc,NO-fail
 */
+ (BOOL)localClearFileCache:(NSString*)fileName;

/**
 *  清除本地所有plist文件
 *
 *  @return result:YES-suc,NO-fail
 */
+ (BOOL)localClearFileCache;

/**
 *  清除指定的文件
 *
 *  @param type 文件类型
 *
 *  @return result:YES-suc,NO-fail
 */
+ (BOOL)localClearFileCacheWithType:(NSString *)type;
@end
