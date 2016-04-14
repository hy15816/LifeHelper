//
//  PhoneAttribution.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "PhoneAttribution.h"

@implementation PhoneAttribution

- (instancetype)attributionWithDict:(NSDictionary *)dic {
    
    if (!dic) {
        NNLog(@"set dic == nil ");
        return nil;
    }
    PhoneAttribution *attribution = [[PhoneAttribution alloc] init];
    attribution.city = [dic stringForKey:@"city"];
    attribution.phone = [dic stringForKey:@"phone"];
    attribution.prefix = [dic stringForKey:@"prefix"];
    attribution.province = [dic stringForKey:@"province"];
    attribution.suit = [dic stringForKey:@"suit"];
    attribution.supplier = [dic stringForKey:@"supplier"];

    return attribution;
}

@end
