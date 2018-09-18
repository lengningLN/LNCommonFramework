//
//  LNTextField.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "LNTextField.h"
NSString * const ZYTextFieldDeleteClickKey = @"ZYTextFieldDeleteClickKey";

@implementation LNTextField

- (void)deleteBackward
{
    [super deleteBackward];
    
    !_deleteAction?:_deleteAction();
    
    // 保证在主线程发通知
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:ZYTextFieldDeleteClickKey object:nil];
    });
}

@end

@implementation UITextField(LNExtension)

- (NSRange)selectedRange
{
    // 获得最开始的位置
    UITextPosition *beginning = self.beginningOfDocument;
    
    // 获取选中文字最开始的位置
    UITextPosition *selectionStart = self.selectedTextRange.start;
    
    // 获取选中文字最末尾的位置
    UITextPosition *selectionEnd = self.selectedTextRange.end;
    
    // 获取选中文字的开始和self开始之间的offset
    NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    
    // 获取选中文字之间的offset
    NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    if (label && [label respondsToSelector:@selector(setTextColor:)]) {
        label.textColor = placeholderColor;
    }
}

- (UIColor *)placeholderColor
{
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    if (label && [label respondsToSelector:@selector(textColor)]) {
        return label.textColor;
    }

    return nil;
}


@end
