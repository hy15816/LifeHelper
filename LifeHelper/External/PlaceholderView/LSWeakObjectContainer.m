//
//  LSWeakObjectContainer.m
//  LifeHelper
//
//  Created by Lost_souls on 16/7/2.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "LSWeakObjectContainer.h"

@implementation LSWeakObjectContainer

- (instancetype)initWithWeakObject:(id)object
{
    self = [super init];
    if (self) {
        _weakObject = object;
    }
    return self;
}

@end
