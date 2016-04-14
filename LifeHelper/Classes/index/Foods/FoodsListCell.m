//
//  FoodsListCell.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/7.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//


#import "FoodsListCell.h"
#import "FoodsListModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+TextHeight.h"

@interface FoodsListCell ()

@property (strong, nonatomic) IBOutlet UIImageView *foodCategoryImage;
@property (strong, nonatomic) IBOutlet UILabel *foodCategoryTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *foodCategoryNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *foodCategoryDescLabel;

@end

@implementation FoodsListCell



- (void)setFoodModel:(FoodsListModel *)foodModel {
    
    
    
    _foodModel = foodModel;
    NSURL *imageUrl = [NSURL URLWithString:kFOOD_URL_IMAGE(foodModel.foodImageUrl)];
    [self.foodCategoryImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"9"] options:SDWebImageRefreshCached];
    self.foodCategoryTitleLabel.text = foodModel.foodName;
    self.foodCategoryDescLabel.text = foodModel.foodDescription;
    
    CGFloat margin = 5;
    CGFloat height = [foodModel.foodDescription heightWithText:foodModel.foodDescription font:[UIFont systemFontOfSize:11] width:self.foodCategoryDescLabel.frame.size.width];
    _foodModel.foodCellHeight = height + margin *3 + self.foodCategoryTitleLabel.frame.size.height;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
