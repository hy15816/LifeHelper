//
//  SharesCell.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/11.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "SharesCell.h"

@interface SharesCell ()
@property (strong, nonatomic) IBOutlet UILabel *sharesNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sharesCodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *sharesNowDataLabel;
@property (strong, nonatomic) IBOutlet UILabel *sharesPresentLabel;

@end

@implementation SharesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSharesModel:(SharesModel *)sharesModel {
    
    _sharesModel = sharesModel;
    
    self.sharesNameLabel.text = sharesModel.sharesName;
    self.sharesCodeLabel.text = sharesModel.sharesCode;
    self.sharesNowDataLabel.text = sharesModel.sharesNowData;
    self.sharesPresentLabel.text = sharesModel.sharesPresent;
}

@end
