//
//  IndexCollectionModel.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexCollectionModel : NSObject

@property (strong,nonatomic) NSString *itemName;
@property (strong,nonatomic) NSString *itemImage;
@property (strong,nonatomic) NSString *itemID;
+(instancetype)modelWithDic:(NSDictionary *)dic;

@end
