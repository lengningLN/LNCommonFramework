//
//  UIView+LNExtension.h
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/18.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LNExtension)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGSize  size;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint centerInSelf;
@property (nonatomic, readonly) CGFloat bottom;
@property (nonatomic, readonly) CGFloat left;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, readonly) CGFloat top;
@property (nonatomic, readonly) NSString *frameString;

@end

@interface UIView (LNMethodExtension)

/**
 *  seting view to no hidden (设置view不隐藏)
 */
@property (nonatomic, assign, getter=isShow) BOOL show;

/**
 支持任何扩展传值
 */
@property (nonatomic, strong) NSDictionary *ext;

/**
 截取当前的view为图片
 
 @return 图片
 */
- (UIImage *)captureImage;

/**
 *  获取touches的point
 */
- (CGPoint)pointWithTouches:(NSSet *)touches;

/**
 *  allow this name to get xib(UINib) instance  获取同名的xibview
 *
 *  @return view
 */
+ (__kindof UIView *)zy_xibView;

/**
 *  get this view's viewController (获取当前view所在的控制器)
 *
 *  @return UIViewController
 */
- (__kindof  UIViewController *)zy_viewController;


- (UIViewController*)viewController;
- (UINavigationController *)navigationController;

@end


////////////////////////
/// xib扩展   ZYSu. 07.19
////////////////////////
@interface UIView (LNXIB)

/**
 边框颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

/**
 边框宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 单个圆角设置
 */
@property (nonatomic, assign) UIRectCorner roundCorners;

@end


@interface LNLineView : UIView
/**
 设置左边距
 */
@property (nonatomic, assign) CGFloat leftMargin;

/**
 设置右边距
 */
@property (nonatomic, assign) CGFloat rightMargin;

/**
 设置线高
 */
@property (nonatomic, assign) CGFloat lineHeight;

/**
 设置线的颜色
 */
@property (nonatomic, strong) UIColor *lineColor;
@end


@interface UIView (LNLine)
- (void)zy_makeTopLine:(void (^)(LNLineView *lineView))make;
- (void)zy_makeBottomLine:(void (^)(LNLineView *lineView))make;

/**
 @return 上边线
 */
- (LNLineView *)topLine;

/**
 @return 下边线
 */
- (LNLineView *)bottomLine;

// xib支持
@property (nonatomic, assign) IBInspectable BOOL showTopLine;
@property (nonatomic, assign) IBInspectable CGPoint topLineMargin;

@property (nonatomic, assign) IBInspectable BOOL showBottomLine;
@property (nonatomic, assign) IBInspectable CGPoint bottomLineMargin;

@end

