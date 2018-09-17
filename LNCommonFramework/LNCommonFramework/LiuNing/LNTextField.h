//
//  LNTextField.h
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 点击了删除键的key
 */
UIKIT_EXTERN NSString * const ZYTextFieldDeleteClickKey;

@interface LNTextField : UITextField
/**
 监听删除的回调
 */
@property (nonatomic, copy) void (^deleteAction)(void);

@end

@interface UITextField (LNExtension)

/**
 选中的文本范围
 */
@property (nonatomic, readonly) NSRange selectedRange;

/**
 占位文字的颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

@end
