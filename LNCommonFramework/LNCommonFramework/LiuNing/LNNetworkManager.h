//
//  LNNetworkManager.h
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/16.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNNetworkManagerConfig : NSObject

/**
 是否自动添加网络加载中提示框
 */
@property (nonatomic, assign) BOOL autoHud;

/**
 下拉刷新的头
 */
@property (nonatomic, weak) MJRefreshHeader *header;

/**
 下拉刷新的足
 */
@property (nonatomic, weak) MJRefreshFooter *footer;

/**
 超时时间
 */
@property (nonatomic, assign) NSTimeInterval timeout;

/**
 失败重试次数
 */
@property (nonatomic, assign) NSInteger retryCount;

@end

@interface LNNetworkManager : NSObject
/**
 发送post请求
 
 @param url URL
 @param setParamsBlock 设置参数 默认已经添加了userId
 @param success 成功的回调
 @param failure 失败的回调
 @param errorCall 失败的回调
 @return 网络请求任务
 */
+ (NSURLSessionDataTask *)POST:(NSString *)url params:(void (^)(NSMutableDictionary *params))setParamsBlock success:(void (^)(id json))success failure:(void (^)(NSInteger code, NSString *info))failure error:(void (^)(NSError *error))errorCall;
@end



@interface UIViewController (LNNetwork)

/**
 发送post请求
 
 @param url URL
 @param setParamsBlock 设置参数 默认已经添加了userId
 @param success 成功的回调
 @param failure 失败的回调
 @param errorCall 失败的回调
 */
- (NSURLSessionTask *)POST:(NSString *)url  params:(void (^)(NSMutableDictionary *params, LNNetworkManagerConfig *config))setParamsBlock success:(void (^)(id json))success failure:(void (^)(NSInteger code, NSString *info))failure error:(void (^)(NSError *error))errorCall;

/**
 设置界面消失自动取消网络请求(require: 需要在网络请求开始之前打开此属性才有效果)
 */
- (void)setCancleNetRequestWhenDisAppear;

/**
 手动取消网络请求
 */
- (void)cancleRequest;




@end



