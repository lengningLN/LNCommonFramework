//
//  NSString+LNExtension.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "NSString+LNExtension.h"

@implementation NSString (LNExtension)

- (NSUInteger)unicodeLength
{
    NSUInteger length = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        int ch = [self characterAtIndex:i];
        // 如果是汉字 +2
        if (isascii(ch)){
            length += 1;
        }else{
            length += 2;
        }
    }
    return length;
}

- (BOOL)isDiffToString:(NSString *)str
{
    return ![self isEqualToString:str];
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSAssert(font != nil, @"font不能为空!!");
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)trimLength
{
    return self.trim.length;
}

- (BOOL)contains:(NSString *)string
{
    if (string.trimLength == 0) {
        return NO;
    }
    
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
        return [self containsString:string];
    }
    
    return (BOOL)([self rangeOfString:string].length > 0);
}

- (BOOL)containsStringIgnoreCase:(NSString *)string
{
    return [self rangeOfStringIgnoreCase:string].length;
}

- (NSRange)rangeOfStringIgnoreCase:(NSString *)searchString
{
    return [self.lowercaseString rangeOfString:searchString.lowercaseString];
}
@end

@implementation NSMutableString (LNExtension)
/**
 拼接字符串
 */
- (NSMutableString * (^)(NSString *str))appStr
{
    return ^(NSString *str){
        if (str.length == 0) {
            return self;
        }
        if ([self respondsToSelector:@selector(appendString:)]) {
            [self appendString:str];
        }
        return self;
    };
}



@end





