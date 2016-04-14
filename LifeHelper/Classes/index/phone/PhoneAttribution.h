//
//  PhoneAttribution.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneAttribution : NSObject

/**
 *  城市
 */
@property (strong,nonatomic) NSString *city;
/**
 *  手机号码
 */
@property (strong,nonatomic) NSString *phone;
/**
 *  后记号码前7位
 */
@property (strong,nonatomic) NSString *prefix;
/**
 *  省份
 */
@property (strong,nonatomic) NSString *province;
/**
 *  例:185卡
 */
@property (strong,nonatomic) NSString *suit;
/**
 *  例:联通
 */
@property (strong,nonatomic) NSString *supplier;

- (instancetype)attributionWithDict:(NSDictionary *)dic;

@end
