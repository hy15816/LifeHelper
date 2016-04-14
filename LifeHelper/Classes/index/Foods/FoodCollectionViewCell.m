//
//  FoodCollectionViewCell.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/7.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "FoodCollectionViewCell.h"

@implementation FoodCollectionViewCell


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //初始化时加载xib
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"FoodCollectionViewCell" owner:self options:nil];
        if (nibArray.count < 1) {
            return nil;
        }
        if (![[nibArray firstObject] isKindOfClass:[FoodCollectionViewCell class]]) {
            return nil;
        }
        self = [nibArray firstObject];
    }
    
    return self;
}


@end
