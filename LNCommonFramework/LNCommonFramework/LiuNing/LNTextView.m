//
//  LNTextView.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "LNTextView.h"

@implementation LNTextView
{
    UILabel *_placeHolderLabel;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self zy_setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self zy_setUp];
    }
    return self;
}

- (void)zy_setUp
{
    _placeHolderStart = CGPointMake(4, 8);
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.textColor = self.textColor;
    _placeHolderLabel.font = self.font;
    _placeHolderColor = [UIColor lightGrayColor];
    _placeHolderLabel.numberOfLines = 0;
    [self addSubview:_placeHolderLabel];
    
    self.placeHolder = @"请输入...";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    _placeHolderLabel.hidden = (text.length > 0);
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    _placeHolderLabel.hidden = (self.text.length > 0 || attributedText.string.length > 0);
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    _placeHolderLabel.font = font;
    [self setNeedsLayout];
}

- (void)textViewTextDidChange:(NSNotification *)notify
{
    _placeHolderLabel.hidden = (self.text.length > 0 || self.attributedText.string.length > 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = [placeHolder copy];
    _placeHolderLabel.text = placeHolder;
    [self setNeedsLayout];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    _placeHolderLabel.textColor = placeHolderColor;
}

- (void)setPlaceHolderStart:(CGPoint)placeHolderStart
{
    _placeHolderStart = placeHolderStart;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat maxW = self.bounds.size.width - _placeHolderStart.x * 2;
    _placeHolderLabel.frame = CGRectMake(_placeHolderStart.x, _placeHolderStart.y, maxW, [_placeHolderLabel.text sizeWithFont:_placeHolderLabel.font maxW:maxW].height);
}
@end
