//
//  LNImagePositionButton.h
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/15.
//  Copyright © 2018年 刘宁. All rights reserved.
//



#import <UIKit/UIKit.h>

#define LNButtonImagePositon NSInteger
UIKIT_EXTERN LNButtonImagePositon const LNButtonImagePositonRight;
UIKIT_EXTERN LNButtonImagePositon const LNButtonImagePostionLeft;
UIKIT_EXTERN LNButtonImagePositon const LNButtonImagePositonTop;
UIKIT_EXTERN LNButtonImagePositon const LNButtonImagePositonBottom;

@interface LNImagePositionButton : UIButton
/**
 设置image的位置,0 :右边， 1：左边， 2：上边， 3：下边
 */
@property (nonatomic, assign)IBInspectable NSInteger ln_imagePosition;

/**
 设置标题和图片之间的间隔
 */
@property (nonatomic, assign)IBInspectable CGFloat ln_titleImageMargin;
@end
