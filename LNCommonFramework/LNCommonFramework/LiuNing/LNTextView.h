//
//  LNTextView.h
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNTextView : UITextField
/**
 占位文字 默认 : 请输入...
 */
@property (nonatomic, copy) IBInspectable NSString *placeHolder;

/**
 占位文字的颜色 默认 : lightGrayColor
 */
@property (nonatomic, copy) IBInspectable UIColor *placeHolderColor;

/**
 占位文字的起始位置(x, y) 默认 : (4,4)
 */
@property (nonatomic, assign) IBInspectable CGPoint placeHolderStart;

@end
