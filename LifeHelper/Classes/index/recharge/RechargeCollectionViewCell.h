//
//  RechargeCollectionViewCell.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/18.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeCollectionViewCell : UICollectionViewCell
/**
 *  充值金额
 */
@property (strong, nonatomic) IBOutlet UILabel *rechargeAmountLabel;
/**
 *  支付金额
 */
@property (strong, nonatomic) IBOutlet UILabel *rechargePaymentLabel;

@end
