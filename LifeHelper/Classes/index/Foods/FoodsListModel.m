//
//  FoodsListModel.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/8.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "FoodsListModel.h"

@implementation FoodsListModel
@synthesize foodCellHeight;

+ (instancetype)modelWithDic:(NSDictionary *)dic {

    FoodsListModel *food = [[FoodsListModel alloc] init];
    food.foodId = [NSString stringWithFormat:@"%@",[dic numberForKey:@"id"]];
    food.foodName = [dic stringForKey:@"name"];
    food.foodDescription = [dic stringForKey:@"description"];
    food.foodImageUrl = [dic stringForKey:@"img"];
    food.foodMessage = [dic stringForKey:@"message"];
    food.foodRelation = [dic stringForKey:@"food"];
    food.foodReadCount = [NSString stringWithFormat:@"%@",[dic numberForKey:@"count"]];
    food.foodReviewsCount = [NSString stringWithFormat:@"%@",[dic numberForKey:@"rcount"]];
    food.foodFunCount = [NSString stringWithFormat:@"%@",[dic numberForKey:@"fcount"]];
    NSString * foodImagesUrlString = [dic stringForKey:@"images"];
    NSArray *urlList = [NSArray new];
    if (foodImagesUrlString.length) {
        urlList = [foodImagesUrlString componentsSeparatedByString:@","];
    }
    food.foodImagesUrlList = urlList;
    
    return food;
}

@end
