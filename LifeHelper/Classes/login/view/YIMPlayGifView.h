//
//  YIMPlayGifView.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 16/1/8.
//  Copyright © 2016年 yim. All rights reserved.
//  加载gif图片并播放,需设置class为 -fno-objc-arc

#import <UIKit/UIKit.h>


@interface YIMPlayGifView : UIView


/**
 *  加载gif图片并播放
 *
 *  @param frame     frame
 *  @param _filePath 文件路径
 *
 *  @return UIView
 */
- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath;
/**
 *  加载gif图片并播放
 *
 *  @param frame frame
 *  @param _data 文件NSData
 *
 *  @return UIView
 */
- (id)initWithFrame:(CGRect)frame data:(NSData *)_data;

@end
