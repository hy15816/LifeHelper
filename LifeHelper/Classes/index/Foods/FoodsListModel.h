//
//  FoodsListModel.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/8.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodsListModel : NSObject

@property (strong, nonatomic) NSString *foodId;
/**
 *  名称
 */
@property (strong, nonatomic) NSString *foodName;
/**
 *  图片路径
 */
@property (strong, nonatomic) NSString *foodImageUrl;
/**
 *  简介，描述
 */
@property (strong, nonatomic) NSString *foodDescription;

/**
 *  (资讯)内容
 */
@property (strong, nonatomic) NSString *foodMessage;
/**
 *  相关食物
 */
@property (strong, nonatomic) NSString *foodRelation;

/**
 *  关键词
 */
@property (strong, nonatomic) NSString *foodKeywords;

/**
 *  浏览量，访问数
 */
@property (strong, nonatomic) NSString *foodReadCount;

/**
 *  评论数
 */
@property (strong, nonatomic) NSString *foodReviewsCount;

/**
 *  收藏数
 */
@property (strong, nonatomic) NSString *foodFunCount;

/**
 *  多图,中间由逗号隔开
 */
@property (strong, nonatomic) NSArray *foodImagesUrlList;

+ (instancetype)modelWithDic:(NSDictionary *)dic;

@property (assign, nonatomic) CGFloat foodCellHeight;

@end
