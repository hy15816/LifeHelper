//
//  NSDictionary+Helper.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/22.
//  Copyright © 2016年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Helper)

- (NSString*) stringForKey:(id)key;

- (NSNumber*) numberForKey:(id)key;

- (NSMutableDictionary*) dictionaryForKey:(id)key;

- (NSMutableArray*) arrayForKey:(id)key;

@end
