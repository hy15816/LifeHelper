//
//  RechargeCollectionHeaderView.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/18.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeCollectionHeaderView : UICollectionReusableView<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *phoneNumField;
@property (strong, nonatomic) IBOutlet UIButton *checkContactButton;
- (IBAction)chekContactButtonAction:(UIButton *)sender;

@property (strong, nonatomic) void (^checkContactClickBlock)();
@property (strong, nonatomic) void (^inputPhoneNumberFinishBlock)(NSString *text);
@end
