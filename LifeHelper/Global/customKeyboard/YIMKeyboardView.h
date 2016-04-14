//
//  YIMKeyboardView.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/19.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YIMKeyboardView : UIView

@property (strong, nonatomic) void (^downButtonActionBlock)(UIButton *btn);
@end
