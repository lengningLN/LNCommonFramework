//
//  LNImagePositionButton.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/15.
//  Copyright © 2018年 刘宁. All rights reserved.
//


#import "LNImagePositionButton.h"
LNButtonImagePositon const LNButtonImagePositonRight = 0;
LNButtonImagePositon const LNButtonImagePostionLeft = 1;
LNButtonImagePositon const LNButtonImagePositonTop = 2;
LNButtonImagePositon const LNButtonImagePositonBottom = 3;

@implementation LNImagePositionButton
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self setNeedsLayout];
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state
{
    [super setAttributedTitle:title forState:state];
    [self setNeedsLayout];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self setNeedsLayout];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置间隔
    self.ln_titleImageMargin = self.ln_titleImageMargin?self.ln_titleImageMargin:4;
    
    //横向排列
    CGFloat contentWidth = self.titleLabel.bounds.size.width+self.imageView.bounds.size.width+self.ln_titleImageMargin;
    CGFloat leftMargin = (self.bounds.size.width-contentWidth)*0.5;
    leftMargin >=0 ? leftMargin:(leftMargin = 0);
    
    //上下排列
    CGFloat contentHeight = self.titleLabel.bounds.size.height+self.imageView.bounds.size.height+self.ln_titleImageMargin;
    CGFloat topMargin = (self.bounds.size.height-contentHeight)*0.5;
    topMargin >=0 ? topMargin:(topMargin = 0);
    
    if (self.ln_imagePosition == LNButtonImagePositonRight) {
        //图片在右边，文字在左边
        self.titleLabel.frame = CGRectMake(leftMargin, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
        
        self.imageView.frame = CGRectMake(self.bounds.size.width-leftMargin-self.imageView.bounds.size.width, self.imageView.frame.origin.y, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
    }else if (self.ln_imagePosition == LNButtonImagePostionLeft){
        // 图片在左
        self.imageView.frame = CGRectMake(leftMargin, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
        
        self.titleLabel.frame = CGRectMake(self.bounds.size.width-leftMargin-self.titleLabel.bounds.size.width, self.titleLabel.frame.origin.y, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);
    }else if (self.ln_imagePosition == LNButtonImagePositonTop){
        // 图片在上
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, topMargin, self.imageView.frame.size.width, self.imageView.frame.size.height);
        self.imageView.center = CGPointMake(self.bounds.size.width*0.5, self.imageView.center.y);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.frame = CGRectMake(0, self.bounds.size.height-topMargin-self.titleLabel.bounds.size.height, self.bounds.size.width, self.titleLabel.bounds.size.height);
    }else{
        //图片在下
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.frame = CGRectMake(0, topMargin, self.bounds.size.width, self.titleLabel.frame.size.height);
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.bounds.size.height-topMargin-self.imageView.bounds.size.height, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
        self.imageView.center = CGPointMake(self.bounds.size.width*0.5, self.imageView.center.y);
    }
}


@end
