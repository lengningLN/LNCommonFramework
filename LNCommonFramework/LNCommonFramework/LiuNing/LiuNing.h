//
//  LiuNing.h
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/17.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#ifndef LiuNing_h
#define LiuNing_h

#define LNScreenWidth [UIScreen mainScreen].bounds.size.width
#define LNScreenHeight [UIScreen mainScreen].bounds.size.height
#define LNColor(r, g, b, a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a * 1.0]
#define LNNotificationCenter [NSNotificationCenter defaultCenter]
#define LNWeakSelf     @weakify(self);   // 防止block循环引用
#define LNStrongSelf   @strongify(self); // 恢复self
#define LNKeyPath(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), #PATH)) // 获取key

#import "LNImagePositionButton.h"
#import "LNNetworkManager.h"
#import "LNProgressHUD.h"
#import "NSAttributedString+LNExtension.h"
#import "NSString+LNExtension.h"
#import "LNMethod.h"
#import "UIView+LNExtension.h"
#import "LNTextField.h"
#import "LNTextView.h"

#endif /* LiuNing_h */
