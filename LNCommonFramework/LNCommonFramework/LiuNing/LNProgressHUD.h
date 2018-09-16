//
//  LNProgressHUD.h
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/16.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>


@protocol LNHUDProtocol <NSObject>

- (void)showLoading;

- (void)showLoading:(NSString *)loadingInfo;

- (void)showInfo:(NSString *)info;

- (void)showTip:(NSString *)tip;

- (void)showSuccess:(NSString *)successInfo;

- (void)showError;

- (void)showError:(NSString *)errorInfo;

- (void)dismiss;

@end

@interface UIViewController (LNHUD) <LNHUDProtocol>
@end

@interface UIView (LNHUD) <LNHUDProtocol>

/**
 正在加载
 */
@property (nonatomic, assign, readonly) BOOL isLoading;

/**
 开始转菊花
 */
- (void)startLoading;

/**
 隐藏
 */
- (void)stopLoading;

@end

@interface MBProgressHUD (LNHUD)

+ (void)showLoading;

+ (void)showLoading:(NSString *)loadingInfo;

+ (void)showInfo:(NSString *)info;

+ (void)showTip:(NSString *)tip;

+ (void)showSuccess:(NSString *)successInfo;

+ (void)showError;

+ (void)showError:(NSString *)errorInfo;

+ (void)dismiss;

@end
