//
//  IndexCollectionModel.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "IndexCollectionModel.h"

@implementation IndexCollectionModel


+(instancetype)modelWithDic:(NSDictionary *)dic {
    
    if (!dic) {
        
        return nil;
    }
    IndexCollectionModel *model = [[IndexCollectionModel alloc] init];
    model.itemName = [dic stringForKey:@"name"];
    model.itemImage = [dic stringForKey:@"image"];
    model.itemID = [dic stringForKey:@"id"];
    
    return model;
}

@end
