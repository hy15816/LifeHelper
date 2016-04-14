//
//  NSString+MD5.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/26.
//  Copyright © 2015年 yim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@interface NSString (MD5)

/**
 *  MD5加密(小写)
 *
 *  @return 加密字符串
 */
- (NSString *)stringWithMD5;

/**
 *  净化字符串
 *
 *  @return <#return value description#>
 */
- (NSString *)purify;



@end
