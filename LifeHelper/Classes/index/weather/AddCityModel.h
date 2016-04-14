//
//  AddCityModel.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/22.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddCityModel : NSObject

@property (strong,nonatomic) NSString *cityId;
@property (strong,nonatomic) NSString *cityName;
@property (strong,nonatomic) NSString *imageName;
@property (strong,nonatomic) NSString *isCheck;
+ (AddCityModel *)modelWithDict:(NSDictionary *)dic ;

@end
