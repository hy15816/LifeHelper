//
//  LSWeakObjectContainer.h
//  LifeHelper
//
//  Created by Lost_souls on 16/7/2.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSWeakObjectContainer : NSObject

@property (nonatomic, readonly, weak) id weakObject;

- (instancetype)initWithWeakObject:(id)object;

@end
