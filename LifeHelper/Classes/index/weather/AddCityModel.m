//
//  AddCityModel.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/22.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "AddCityModel.h"

@implementation AddCityModel

+ (AddCityModel *)modelWithDict:(NSDictionary *)dic  {
    
    if (!dic) {
        NNLog(@"[modelWithDict:] --> dic == nil");
        return nil;
    }
    
    AddCityModel *model = [[AddCityModel alloc] init];
    model.cityId = [dic stringForKey:@"cityId"];
    model.cityName = [dic stringForKey:@"cityName"];
    model.imageName = [dic stringForKey:@"imageName"];
    model.isCheck = [dic stringForKey:@"isCheck"];
    return model;
}
@end
