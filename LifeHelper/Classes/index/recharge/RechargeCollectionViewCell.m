//
//  RechargeCollectionViewCell.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/18.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "RechargeCollectionViewCell.h"

@implementation RechargeCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //
        //初始化时加载xib
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"RechargeCollectionViewCell" owner:self options:nil];
        if (nibArray.count < 1) {
            return nil;
        }
        if (![[nibArray firstObject] isKindOfClass:[RechargeCollectionViewCell class]]) {
            return nil;
        }
        self = [nibArray firstObject];
    }
    
    return self;
}

@end
