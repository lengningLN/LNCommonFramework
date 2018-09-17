//
//  NSAttributedString+LNExtension.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "NSAttributedString+LNExtension.h"

@implementation NSAttributedString (LNExtension)
+ (instancetype)attributedString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment
{
    if (!string.length) {
        return nil;
    }
    NSAssert(color != nil, @"颜色不能为空!!");
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = alignment;
    return [[self alloc] initWithString:string attributes:
            @{
              NSFontAttributeName : [UIFont systemFontOfSize:fontsize],
              NSForegroundColorAttributeName : color,
              NSParagraphStyleAttributeName:paragraphStyle
              }];
}
@end


@implementation NSMutableAttributedString (LNExtension)

- (void)setLineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = lineSpacing;
    [self addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
}

- (CGFloat)lineSpacing
{
    NSRange range = NSMakeRange(0, self.length);
    NSMutableParagraphStyle *style = [self attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
    if (style) {
        return style.lineSpacing;
    }
    return 0.0;
}

- (void)setParagraphSpacing:(CGFloat)paragraphSpacing
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.paragraphSpacing = paragraphSpacing;
    [self addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
}

- (CGFloat)paragraphSpacing
{
    NSRange range = NSMakeRange(0, self.length);
    NSMutableParagraphStyle *style = [self attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
    if (style) {
        return style.paragraphSpacing;
    }
    return 0.0;
}

- (NSMutableAttributedString *)appendString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment
{
    NSAttributedString *str = [NSAttributedString attributedString:string color:color fontsize:fontsize alignment:alignment];
    if (str.length) {
        [self appendAttributedString:str];
    }else{
        NSLog(@"%@ 插入的字符串为空", self);
    }
    return self;
}


@end
