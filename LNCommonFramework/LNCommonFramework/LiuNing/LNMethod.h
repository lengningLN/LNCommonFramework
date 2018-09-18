//
//  LNMethod.h
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/18.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^block)(void);

/**
 获取storyboard的控制器

 @param sbvcName sbname
 @return sbvc
 */
id LNSBViewController(NSString *sbvcName);



/**
 获取xibview

 @param xibViewName xibname
 @return xibview
 */
UIView *LNXibView(NSString *xibViewName);


/**
 获取分辨率倍数

 @return 当前分辨率倍数
 */
CGFloat LNScreenScale(void);


CGRect LNScreenBounds(void);

CGSize LNScreenSize(void);

/**
 延迟执行喊出

 @param time 延迟时间
 @param block code
 */
void LNAfer(NSTimeInterval time, block);


/**
 开启异步执行block

 @param block 异步code
 */
void LNAsyncThread(block);

/**
 回到主线程

 @param block mainCode
 */
void LNMainThread(block);

