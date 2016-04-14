//
//  NSDictionary+Helper.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/22.
//  Copyright © 2016年 yim. All rights reserved.
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)

- (NSString*) stringForKey:(id)key {
    
    id s = [self objectForKey:key];
    if (s == [NSNull null] || ![s isKindOfClass:[NSString class]]) {
        return @"";
    }
    return s;
}


- (NSNumber*) numberForKey:(id)key {
    id s = [self objectForKey:key];
    if (s == [NSNull null] || ![s isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    return s;
}

- (NSMutableDictionary*) dictionaryForKey:(id)key {
    id s = [self objectForKey:key];
    if (s == [NSNull null] || ![s isKindOfClass:[NSMutableDictionary class]]) {
        return nil;
    }
    return s;
}

- (NSMutableArray*) arrayForKey:(id)key {
    id s = [self objectForKey:key];
    if (s == [NSNull null] || ![s isKindOfClass:[NSMutableArray class]]) {
        return nil;
    }
    return s;
}

@end
