//
//  SharesModel.h
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/4/11.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharesModel : NSObject

@property (strong, nonatomic) NSString *sharesName;
@property (strong, nonatomic) NSString *sharesCode;
@property (strong, nonatomic) NSString *sharesNowData;
@property (strong, nonatomic) NSString *sharesPresent;

+ (instancetype)model:(NSDictionary *)dic;

@end
