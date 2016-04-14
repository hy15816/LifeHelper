//
//  NSString+MD5.m
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/26.
//  Copyright © 2015年 yim. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)

/**
 *  MD5加密
 *
 *  @return 加密字符串
 */
- (NSString *)stringWithMD5 {
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (NSString *)purify {
    NSString *original = self;
    original = [original stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//去除左右两边的空格、换行符
    original = [original stringByReplacingOccurrencesOfString:@" " withString:@""];//去除中间的空格
    original = [original stringByReplacingOccurrencesOfString:@"\r" withString:@""];//去除换行符
    original = [original stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    original = [original stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return original;
}



@end
