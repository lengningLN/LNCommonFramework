//
//  LNMethod.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/18.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "LNMethod.h"


id LNSBViewController(NSString *sbvcName)
{
    return [UIStoryboard storyboardWithName:sbvcName bundle:nil].instantiateInitialViewController;
}


UIView *LNXibView(NSString *xibViewName)
{
    return [[NSBundle mainBundle]loadNibNamed:xibViewName owner:nil options:nil].firstObject;
}

CGFloat LNScreenScale(void)
{
    static CGFloat screenScale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        screenScale = [UIScreen mainScreen].scale;
    });
    return screenScale;
}


CGRect LNScreenBounds(void)
{
    static CGRect screenRect;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        screenRect = [UIScreen mainScreen].bounds;
    });
    return screenRect;
}

CGSize LNScreenSize(void)
{
    static CGSize screenSize;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        screenSize = [UIScreen mainScreen].bounds.size;
    });
    return screenSize;
}

