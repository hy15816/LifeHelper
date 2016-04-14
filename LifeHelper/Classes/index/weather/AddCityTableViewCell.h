//
//  AddCityTableViewCell.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/22.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCityModel.h"

@interface AddCityTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *leftNameButton;
@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;

@property (strong, nonatomic) IBOutlet UIButton *centerNameButton;
@property (strong, nonatomic) IBOutlet UIImageView *centerImageView;

@property (strong, nonatomic) IBOutlet UIButton *rightNameButton;
@property (strong, nonatomic) IBOutlet UIImageView *rightImageView;

@property (strong, nonatomic) IBOutlet UILabel *rightLine;

- (IBAction)leftTapAction:(UIButton *)sender;

+ (AddCityTableViewCell *)cellWithTableView:(UITableView *)tableView;

@property (strong,nonatomic) void (^buttonTapActionBlock)();

@property (strong,nonatomic) AddCityModel *leftCityModel;
@property (strong,nonatomic) AddCityModel *centerCityModel;
@property (strong,nonatomic) AddCityModel *rightCityModel;

@end
