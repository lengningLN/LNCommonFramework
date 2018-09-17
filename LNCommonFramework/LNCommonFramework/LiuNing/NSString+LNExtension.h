//
//  NSString+LNExtension.h
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LNExtension)

/**
 @return 纯字符长度
 */
- (NSUInteger)unicodeLength;

/**
 和匹配的字符串不相同
 
 @param str 需要比较的字符串
 @return 结果
 */
- (BOOL)isDiffToString:(NSString *)str;

/**
 根据字号计算文字大小(一行)
 
 @param font 字号
 @return 大小
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/**
 根据字号计算文字大小(一行)
 
 @param font 字号
 @return 大小
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 去除空格
 
 @return 去除空格后的字符串
 */
- (NSString *)trim;

/**
 去除空格之后的长度
 */
- (NSUInteger)trimLength;

/**
 判断是否包含某个字符串
 */
- (BOOL)contains:(NSString *)string;

/**
 判断是否包含某个字符串,忽略大小写
 
 @param string 忽略大小写
 @return 查找结果
 */
- (BOOL)containsStringIgnoreCase:(NSString *)string;

/**
 判断字符串的范围,忽略大小写
 
 @param searchString 要查找的字符串
 @return 范围
 */
- (NSRange)rangeOfStringIgnoreCase:(NSString *)searchString;

@end


@interface NSMutableString (LNExtension)
/**
 拼接字符串
 */
- (NSMutableString * (^)(NSString *str))appStr;


@end
