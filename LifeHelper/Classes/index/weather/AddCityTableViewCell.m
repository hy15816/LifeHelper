//
//  AddCityTableViewCell.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/22.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "AddCityTableViewCell.h"

@implementation AddCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)leftTapAction:(UIButton *)sender {
    
//    NNLog(@"left tap");
    
    if (self.buttonTapActionBlock) {
        self.buttonTapActionBlock(sender);
    }
    
}

+ (AddCityTableViewCell *)cellWithTableView:(UITableView *)tableView {
    AddCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddCityTableViewCell" owner:self options:nil] lastObject];
        
    }
    
    return cell;
}


- (void)setLeftCityModel:(AddCityModel *)leftCityModel {
    
    [self.leftNameButton setTitle:leftCityModel.cityName forState:UIControlStateNormal];
    self.leftNameButton.tag = [leftCityModel.cityId integerValue];
    if ([leftCityModel.isCheck integerValue] == 1) {
        self.leftImageView.backgroundColor = [UIColor greenColor];
    }
}

- (void)setCenterCityModel:(AddCityModel *)centerCityModel {
    
    if (centerCityModel) {
        [self.centerNameButton setTitle:centerCityModel.cityName forState:UIControlStateNormal];
        
        self.centerNameButton.tag = [centerCityModel.cityId integerValue];
    }else {
        self.centerNameButton.hidden = YES;
    }
    
    if ([centerCityModel.isCheck integerValue] == 1) {
        self.centerImageView.backgroundColor = [UIColor greenColor];
    }
}


- (void)setRightCityModel:(AddCityModel *)rightCityModel{
    if (rightCityModel) {
        [self.rightNameButton setTitle:rightCityModel.cityName forState:UIControlStateNormal];
        self.rightNameButton.tag = [rightCityModel.cityId integerValue];
    }else {
        self.rightNameButton.hidden = YES;
        self.rightLine.hidden = YES;
    }
    
    if ([rightCityModel.isCheck integerValue] == 1) {
        self.rightImageView.backgroundColor = [UIColor greenColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
