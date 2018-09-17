//
//  NSAttributedString+LNExtension.h
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (LNExtension)
/**
 快速创建属性字符串
 
 @param color 颜色
 @param fontsize 字号
 @return 属性字符串
 */
+ (instancetype)attributedString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment;
@end

@interface NSMutableAttributedString (LNExtension)

/**
 行间距
 */
@property(nonatomic, assign) CGFloat lineSpacing;

/**
 段间距
 */
@property(nonatomic, assign) CGFloat paragraphSpacing;

/**
 拼接字符串
 
 @param string 字符串
 @param color 颜色
 @param fontsize 字号
 @return 新的字符串
 */
- (NSMutableAttributedString *)appendString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment;

@end
