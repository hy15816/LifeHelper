//
//  AddCityCollectionViewCell.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/22.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "AddCityCollectionViewCell.h"

@implementation AddCityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //
        //初始化时加载xib
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"AddCityCollectionViewCell" owner:self options:nil];
        if (nibArray.count < 1) {
            return nil;
        }
        if (![[nibArray firstObject] isKindOfClass:[AddCityCollectionViewCell class]]) {
            return nil;
        }
        self = [nibArray firstObject];
    }
    
    return self;
}

@end
