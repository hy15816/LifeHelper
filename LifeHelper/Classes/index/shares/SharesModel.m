//
//  SharesModel.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/11.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "SharesModel.h"

@implementation SharesModel

+ (instancetype)model:(NSDictionary *)dic {
    
    SharesModel *model = [[SharesModel alloc] init];
    model.sharesName = [dic stringForKey:@"name"];
    model.sharesCode = [dic stringForKey:@"code"];
    model.sharesNowData = [dic stringForKey:@"industry"];
    model.sharesPresent = [dic stringForKey:@"eps"];
    
    return model;
}
@end
