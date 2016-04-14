//
//  IndexCollectionCell.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "IndexCollectionCell.h"

@implementation IndexCollectionCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //初始化时加载xib
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"IndexCollectionCell" owner:self options:nil];
        if (nibArray.count < 1) {
            return nil;
        }
        if (![[nibArray firstObject] isKindOfClass:[IndexCollectionCell class]]) {
            return nil;
        }
        self = [nibArray firstObject];
    }
    
    return self;
}

-(void)setCollectionModel:(IndexCollectionModel *)collectionModel {
    
    _collectionModel = collectionModel;
    
    self.itemNameLabel.text = collectionModel.itemName;
    self.itemImageView.image = [UIImage imageNamed:collectionModel.itemImage];
    
}

@end
