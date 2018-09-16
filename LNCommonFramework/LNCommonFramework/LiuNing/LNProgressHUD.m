//
//  LNProgressHUD.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/16.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "LNProgressHUD.h"
#import <objc/runtime.h>
#import <Masonry.h>

#ifndef LNScreenHeight
#define LNScreenHeight [UIScreen mainScreen].bounds.size.height
#endif

#ifndef LNScreenWidth
#define LNScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef LNLastWindow
#define LNLastWindow [UIApplication sharedApplication].windows.firstObject
#endif

static CGFloat const kSystemDelay = 0.5;

// 自定义progressHUD
@interface LNProgressHUD : MBProgressHUD
@end

@implementation LNProgressHUD

- (instancetype)initWithFrame:(CGRect)frame
{
    //    CGRect newFrame = frame;
    //    if (frame.origin.y == 0 && frame.size.height == LNScreenHeight) {
    //        newFrame = CGRectMake(frame.origin.x, 0, frame.size.width, LNScreenHeight);
    //    }
    
    if (self = [super initWithFrame:frame]) {
        //        self.contentColor = [UIColor whiteColor];
        //        self.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.offset = CGPointMake(0, -100);
        self.label.font = [UIFont systemFontOfSize:14];
        self.label.numberOfLines = 0;
        self.minSize = CGSizeMake(130, 50);
    }
    return self;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGFloat navH = 64;
//    self.frame = CGRectMake(0, navH, LNScreenWidth, LNScreenHeight - navH);
//    self.backgroundView.frame = self.bounds;
//}

@end

@interface UIView ()
@property (nonatomic, strong) UIView *loadingV;
@end

@implementation UIView (LNHUD)

- (void)showLoading
{
    [self showLoading:@"加载中"];
}

- (void)showLoading:(NSString *)loadingInfo
{
    [self dismiss];
    LNProgressHUD *hud = [LNProgressHUD showHUDAddedTo:self animated:YES];
    hud.label.text = loadingInfo.length?loadingInfo:@"加载中";
}

- (void)showInfo:(NSString *)info
{
    [self showTip:info];
}

- (void)showTip:(NSString *)tip
{
    [self dismiss];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    hud.offset = CGPointMake(0, -80);
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.label.numberOfLines = 0;
    hud.minSize = CGSizeMake(130, 44);
    hud.mode = MBProgressHUDModeText;
    hud.label.text = tip.length?tip:@"系统异常";
    [hud hideAnimated:YES afterDelay:kSystemDelay];
}

- (void)showSuccess:(NSString *)successInfo
{
    [self dismiss];
    LNProgressHUD *hud = [LNProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [UIImage imageNamed:@"Checkmark"];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.label.text = successInfo.length?successInfo:@"成功";
    [hud hideAnimated:YES afterDelay:kSystemDelay];
}

- (void)showError
{
    [self showError:nil];
}

- (void)showError:(NSString *)errorInfo
{
    [self showTip:errorInfo.length?errorInfo:@"网络加载失败"];
}

- (void)dismiss
{
    [LNProgressHUD hideHUDForView:self animated:YES];
}

- (void)startLoading
{
    [self addSubview:self.loadingV];
    
    self.loadingV.frame = self.bounds;
    
    [self.loadingV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self);
        make.center.equalTo(self);
    }];
    
    [(UIActivityIndicatorView *)[self.loadingV viewWithTag:10] startAnimating];
}

- (void)stopLoading
{
    [self.loadingV removeFromSuperview];
    
    [(UIActivityIndicatorView *)[self.loadingV viewWithTag:10] stopAnimating];
}

- (UIView *)loadingV
{
    UIView *loadingV = objc_getAssociatedObject(self, _cmd);
    if (loadingV == nil) {
        loadingV = [UIView new];
        loadingV.backgroundColor = [UIColor whiteColor];
        UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        act.tag = 10;
        [loadingV addSubview:act];
        
        // 添加约束
        [act mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(loadingV);
        }];
        objc_setAssociatedObject(self, _cmd, loadingV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return loadingV;
}

- (BOOL)isLoading
{
    UIView *loadingV = objc_getAssociatedObject(self, @selector(loadingV));
    return loadingV?(loadingV.superview?YES:NO):NO;
}

@end


@implementation UIViewController (LNHUD)

- (void)showLoading
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showLoading:@"加载中"];
    }else{
        [self.view showLoading:@"加载中"];
    }
}

- (void)showLoading:(NSString *)loadingInfo
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showLoading:loadingInfo];
    }else{
        [self.view showLoading:loadingInfo];
    }
}

- (void)showInfo:(NSString *)info
{
    [self showTip:info];
}
- (void)showTip:(NSString *)tip
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showTip:tip];
    }else{
        [self.view showTip:tip];
    }
}


- (void)showSuccess:(NSString *)successInfo
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showSuccess:successInfo];
    }else{
        [self.view showSuccess:successInfo];
    }
}

- (void)showError
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showError];
    }else{
        [self.view showError];
    }
}

- (void)showError:(NSString *)errorInfo
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD showError:errorInfo];
    }else{
        [self.view showError:errorInfo];
    }
}

- (void)dismiss
{
    if ([self isKindOfClass:[UITableViewController class]]) {
        [MBProgressHUD dismiss];
    }else{
        [self.view dismiss];
    }
}

@end

@implementation MBProgressHUD (LNHUD)

+ (void)showLoading
{
    [LNLastWindow showLoading:@"加载中"];
}

+ (void)showLoading:(NSString *)loadingInfo
{
    [LNLastWindow showLoading:loadingInfo];
}

+ (void)showInfo:(NSString *)info
{
    [LNLastWindow showTip:info];
}
+ (void)showTip:(NSString *)tip
{
    [LNLastWindow showTip:tip];
}
+ (void)showSuccess:(NSString *)successInfo
{
    [LNLastWindow showSuccess:successInfo];
}

+ (void)showError
{
    [LNLastWindow showError];
}

+ (void)showError:(NSString *)errorInfo
{
    [LNLastWindow showError:errorInfo];
}

+ (void)dismiss
{
    [LNLastWindow dismiss];
}

@end
