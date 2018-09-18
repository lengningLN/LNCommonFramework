//
//  UIView+LNExtension.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/18.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "UIView+LNExtension.h"

@implementation UIView (LNExtension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.bounds.size.width;
}

- (CGFloat)height
{
    return self.bounds.size.height;
}

- (CGSize)size
{
    return self.bounds.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)middleX
{
    return self.bounds.size.width * 0.5;
}

- (CGFloat)middleY
{
    return self.bounds.size.height * 0.5;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.bounds.size.height;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.bounds.size.width;
}

- (CGPoint)centerInSelf
{
    return CGPointMake(self.middleX, self.middleY);
}

- (NSString *)frameString
{
    return NSStringFromCGRect(self.frame);
}
@end

@implementation UIView (LNMethodExtension)

- (void)setShow:(BOOL)show
{
    self.hidden = !show;
}

- (BOOL)isShow
{
    return !self.isHidden;
}

- (void)setExt:(NSDictionary *)ext
{
    objc_setAssociatedObject(self, @selector(ext), ext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)ext
{
    return objc_getAssociatedObject(self, _cmd);
}

+ (UIView *)zy_xibView
{
    NSString *className = NSStringFromClass([self class]);
    if (className) {
        return [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil].firstObject;
    }
    return nil;
}

- (UIImage *)captureImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [[UIColor whiteColor] setFill];
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)addAnimation:(CAAnimation *)animation
{
    [self addAnimation:animation forKey:nil];
}

- (void)addAnimation:(CAAnimation *)animation forKey:(NSString *)key
{
    [self.layer addAnimation:animation forKey:key];
}

- (void)setCornerRadius:(CGFloat)radius
{
    if (radius < 0) {
        self.layer.cornerRadius = self.middleX;
    }else{
        self.layer.cornerRadius = radius;
    }
    self.layer.masksToBounds = YES;
}

- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    
    return [touch locationInView:self];
}

- (UIViewController *)zy_viewController
{
    id vc = self;
    while (vc && [vc isKindOfClass:[UIViewController class]] == NO) {
        vc = [vc nextResponder];
    }
    return vc;
}

- (UIViewController*)viewController {
    return [self zy_viewController];
}

- (UINavigationController *)navigationController{
    UIViewController *viewController = [self zy_viewController];
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)viewController;
    }
    return viewController?viewController.navigationController:nil;
}

@end



@implementation UIView (LNXIB)

- (void)setBorderColor:(UIColor *)borderColor
{
    if (!self.layer.borderWidth) {
        self.layer.borderWidth = 1.0f;
    }
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor
{
    if (self.layer.borderColor) {
        return [UIColor colorWithCGColor:self.layer.borderColor];
    }
    return self.backgroundColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}
- (void)setRoundCorners:(UIRectCorner)roundCorners
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:roundCorners cornerRadii:CGSizeMake(4,4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end

#define ZYLineViewDefaultHeight 1
#define ZYLineViewDefaultColor  [UIColor colorWithHexString:@"#f5f5f5"]

@implementation LNLineView
{
    // 是不是topLine
    BOOL isTopLine;
}

- (void)setLineHeight:(CGFloat)lineHeight
{
    _lineHeight = lineHeight;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(lineHeight));
    }];
}

- (void)setLeftMargin:(CGFloat)leftMargin
{
    _leftMargin = leftMargin;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(leftMargin));
    }];
}

- (void)setRightMargin:(CGFloat)rightMargin
{
    _rightMargin = rightMargin;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(rightMargin);
    }];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.backgroundColor = lineColor;
}
@end
