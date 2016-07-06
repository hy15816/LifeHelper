//
//  GlobalTool.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/15.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#define kDocumentPath   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kPlistPath(fileName) [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]]
#define kFileName [[[UIDevice currentDevice] identifierForVendor] UUIDString]


#import "GlobalTool.h"
#import "NSString+MD5.h"

@interface GlobalTool ()

@property (strong,nonatomic) NSMutableArray *actsList;

@end

@implementation GlobalTool

+ (GlobalTool *)shar {
    static GlobalTool *global = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[GlobalTool alloc] init];
        }
    });
    
    return global;
}

+ (NSString *)dateStringWithFormat:(NSString *)formate {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSString *destString = [formatter stringFromDate:date];
    return destString;
    
}

+ (NSString *)generateTradeNO {
    static int kNumber = 6;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    
    return [NSString stringWithFormat:@"%@%@",[[GlobalTool shar] patOutOrderNo],resultStr];
}

- (NSString *)patOutOrderNo {
    
    return[NSString stringWithFormat:@"%ld",time(0)];
}






#pragma mark - 手机号码验证
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,6,7,8]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

+ (NSString *)turnPinYinWithHanZi:(NSString *)hanziString  {
    
    NSMutableString *ms = [[NSMutableString alloc] initWithString:hanziString];
    NSMutableString *ms_l = [[NSMutableString alloc] init];
    for (int i=0; i<ms.length; i++) {
        NSMutableString *chart = [[NSMutableString alloc] initWithString:[ms substringWithRange:NSMakeRange(i, 1)]];
        CFStringTransform((__bridge CFMutableStringRef)chart, 0, kCFStringTransformMandarinLatin, NO);      //带音标的拼音
        CFStringTransform((__bridge CFMutableStringRef)chart, 0, kCFStringTransformStripDiacritics, NO);    //去掉音标
        [ms_l appendString:chart];
    }
    
    
    return ms_l;
}

#pragma mark - ====local====

+ (BOOL)localSaveDatas:(NSMutableArray *)arr name:(NSString*)fileName {
    
    NSLog(@"kFileName:%@",[self filePath:fileName]);
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self filePath:fileName]]) {
        NSArray *arr = [[NSArray alloc] init];
        [arr writeToFile:[self filePath:fileName] atomically:YES];
    }
    
    BOOL write = [arr writeToFile:[self filePath:fileName] atomically:YES];
    
    return write;
}

+ (BOOL)localSaveDatasWithDict:(NSDictionary *)dic name:(NSString*)fileName {
    
    NSLog(@"kFileName:%@",[self filePath:fileName]);
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self filePath:fileName]]) {
        NSDictionary *dic = [[NSDictionary alloc] init];
        [dic writeToFile:[self filePath:fileName] atomically:YES];
    }
    
    BOOL write = [dic writeToFile:[self filePath:fileName] atomically:YES];
    
    return write;
}

+ (NSArray *)localAllData:(NSString*)fileName; {
    
    NSLog(@"kFileName:%@",[self filePath:fileName]);
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self filePath:fileName]]) {
        NSArray *arr = [[NSArray alloc] init];
        [arr writeToFile:[self filePath:fileName] atomically:YES];
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:[self filePath:fileName]];
    
    return (NSArray *)array;
}

+ (NSDictionary *)localAllDataDict:(NSString*)fileName; {
    
    NSLog(@"kFileName:%@",[self filePath:fileName]);
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self filePath:fileName]]) {
        NSDictionary *dic = [[NSDictionary alloc] init];
        [dic writeToFile:[self filePath:fileName] atomically:YES];
    }
    
    NSDictionary *dicts = [[NSDictionary alloc] initWithContentsOfFile:[self filePath:fileName]];
    
    return dicts;
}


+ (NSString *)filePath:(NSString *)name {
    
    NSString *directories = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *fileName = [NSString stringWithFormat:@"%@_%@",name,[self dateStringWithFormat:@"yyyyMMddHHmmss"]];
    NSString *path = [directories stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    
    return path;
}

/**
 *  清除指定文件
 *
 *  @param fileName 文件名
 *
 *  @return result:YES-suc,NO-fail
 */
+ (BOOL)localClearFileCache:(NSString*)fileName{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:kPlistPath(fileName)];
    [array removeAllObjects];
    return  [array writeToFile:kPlistPath(fileName) atomically:YES];
}

/**
 *  清除本地所有plist文件
 *
 *  @return result:YES-suc,NO-fail
 */
+ (BOOL)localClearFileCache{
    
    NSString *extension = @"plist";
    return [self clearFileWithType:extension];
}

/**
 *  清除指定的文件
 *
 *  @param type 文件类型
 *
 *  @return result:YES-suc,NO-fail
 */
+ (BOOL)localClearFileCacheWithType:(NSString *)type {
    
    return [self clearFileWithType:type];
}

+ (BOOL)clearFileWithType:(NSString *)type {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    BOOL remove = NO;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:type]) {
            
            remove = [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
    
    return remove;
}


#pragma mark - UIActivityIndicatorView

+ (void)showActInView:(UIView *)view {
    [[GlobalTool shar] showActInView:view];
}

- (void)showActInView:(UIView *)view{
    UIActivityIndicatorView *_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicatorView.frame = CGRectMake(10, (view.frame.size.height -10)/2, 10, 10);
    _activityIndicatorView.color = [UIColor grayColor];
    //    _activityIndicatorView.center = view.center;
    [view addSubview:_activityIndicatorView];
    
    dispatch_main(^{
        [_activityIndicatorView startAnimating];
    });
    
    [self.actsList addObject:_activityIndicatorView];
}


+ (void)dismissAct:(NSInteger)index {
    
    [[GlobalTool shar] dismissAct:index];
}
- (void)dismissAct:(NSInteger)index{
    if (index == -1) {
        for (UIActivityIndicatorView *act in self.actsList) {
            dispatch_main(^{
                [act stopAnimating];
            });
        }
    }else{
        if (index < self.actsList.count) {
            
            UIActivityIndicatorView *act = (UIActivityIndicatorView *)self.actsList[index];
            dispatch_main(^{
                [act stopAnimating];
            });
        }else{
            NSAssert([GlobalTool class], @"index must less than acts count");
        }
    }
}


#pragma mark - setters  & getters

- (NSMutableArray *)actsList{
    if (!_actsList) {
        _actsList = [[NSMutableArray alloc] init];
    }
    return _actsList;
}

@end
