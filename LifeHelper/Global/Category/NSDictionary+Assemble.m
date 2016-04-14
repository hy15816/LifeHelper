//
//  NSDictionary+Assemble.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/18.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "NSDictionary+Assemble.h"

@implementation NSDictionary (Assemble)


+ (NSDictionary *)userName:(NSString *)name documentCode:(NSString *)code  {
    
    if (!name || [code isEqual:[NSNull null]]) {
        name = @"";
    }
    if (!code || [code isEqual:[NSNull null]]) {
        code = @"";
    }
    
    return @{@"":name,@"documentCode":code};
}


@end
