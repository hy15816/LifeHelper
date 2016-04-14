//
//  RechargeCollectionHeaderView.m
//  LifeHelper
//
//  Created by AEF-RD-1 on 16/3/18.
//  Copyright © 2016年 ___lost...souls__yim4ever. All rights reserved.
//

#import "RechargeCollectionHeaderView.h"
#import "UITextField+AKNumericFormatter.h"
#import "AKNumericFormatter.h"

@implementation RechargeCollectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NNLog(@"");
    self.phoneNumField.delegate = self;
    [self formatWithField];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //
        //初始化时加载xib
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"RechargeCollectionHeaderView" owner:self options:nil];
        if (nibArray.count < 1) {
            return nil;
        }
        if (![[nibArray firstObject] isKindOfClass:[RechargeCollectionHeaderView class]]) {
            return nil;
        }
        self = [nibArray firstObject];
    }
    
    return self;
}

- (IBAction)chekContactButtonAction:(UIButton *)sender {
    
    if (self.checkContactClickBlock) {
        self.checkContactClickBlock();
    }
}

#pragma mark - 格式化输入

// 第三方,   #import "UITextField+AKNumericFormatter.h"
//          #import "AKNumericFormatter.h"

- (void)formatWithField {
    
    self.phoneNumField.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    dispatch_main(^{
        if (self.inputPhoneNumberFinishBlock) {
            self.inputPhoneNumberFinishBlock(textField.text);
        }
    });
    
    return YES;
}

/*
 // 格式化输入：手机号码 3-4-4
 // 方法二：
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NNLog(@"range:%@",NSStringFromRange(range));
    
    dispatch_main(^{
        if (self.inputPhoneNumberFinishBlock) {
            self.inputPhoneNumberFinishBlock(textField.text);
        }
    });
    
    
    if (textField) {
        NSString* text = textField.text;
        //删除
        if([string isEqualToString:@""]){
            
            //删除一位
            if(range.length == 1){
                //最后一位,遇到空格则多删除一次
                if (range.location == text.length-1 ) {
                    if ([text characterAtIndex:text.length-1] == ' ') {
                        [textField deleteBackward];
                    }
                    return YES;
                }
                //从中间删除
                else{
                    NSInteger offset = range.location;
                    
                    if (range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]) {
                        [textField deleteBackward];
                        offset --;
                    }
                    [textField deleteBackward];
                    textField.text = [self parseString:textField.text];
                    UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                    return NO;
                }
            }
            else if (range.length > 1) {
                BOOL isLast = NO;
                //如果是从最后一位开始
                if(range.location + range.length == textField.text.length ){
                    isLast = YES;
                }
                [textField deleteBackward];
                textField.text = [self parseString:textField.text];
                
                NSInteger offset = range.location;
                if (range.location == 3 || range.location  == 8) {
                    offset ++;
                }
                if (isLast) {
                    //光标直接在最后一位了
                }else{
                    UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                }
                
                return NO;
            }
            
            else{
                return YES;
            }
        }
        
        else if(string.length >0){
            
            //限制输入字符个数
            if (([self noneSpaseString:textField.text].length + string.length - range.length > 11) ) {
                
                return NO;
            }
            //判断是否是纯数字(千杀的搜狗，百度输入法，数字键盘居然可以输入其他字符)
            //            if(![string isNum]){
            //                return NO;
            //            }
            [textField insertText:string];
            textField.text = [self parseString:textField.text];
            
            NSInteger offset = range.location + string.length;
            if (range.location == 3 || range.location  == 8) {
                offset ++;
            }
            UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
            textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
            return NO;
        }else{
            return YES;
        }
        
    }
    
    
    
    return YES;
    
}


-(NSString*)noneSpaseString:(NSString*)string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString*)parseString:(NSString*)string
{
    if (!string) {
        return nil;
    }
    NSMutableString* mStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if (mStr.length >3) {
        [mStr insertString:@" " atIndex:3];
    }if (mStr.length > 8) {
        [mStr insertString:@" " atIndex:8];
        
    }
    
    return  mStr;
}

 */

/*
 
 // 格式化输入：银行卡号码 4-4-4-4
 // 方法：NSNumberFormatter
 -(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 
 NSString *text = [textField text];
 
 NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
 string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
 if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
 return NO;
 }
 
 text = [text stringByReplacingCharactersInRange:range withString:string];
 text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
 
 NSString *newString = @"";
 while (text.length > 0) {
 NSString *subString = [text substringToIndex:MIN(text.length, 4)];
 newString = [newString stringByAppendingString:subString];
 if (subString.length == 4) {
 newString = [newString stringByAppendingString:@" "];
 }
 text = [text substringFromIndex:MIN(text.length, 4)];
 }
 
 newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
 
 if (newString.length >= 20) {
 return NO;
 }
 
 [textField setText:newString];
 
 return NO;
 }

 
 
*/








@end
