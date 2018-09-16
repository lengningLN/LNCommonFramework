//
//  LNNetworkManager.m
//  LNCommonFramework
//
//  Created by 刘宁 on 2018/9/16.
//  Copyright © 2018年 刘宁. All rights reserved.
//

#import "LNNetworkManager.h"
#import "LNProgressHUD.h"

#pragma mark - 对AFNetworking的封装
@interface _LNSessionManager :AFHTTPSessionManager
+ (instancetype)_lnsessionManager;

@end

@implementation LNNetworkManagerConfig
@end

@implementation LNNetworkManager
+ (NSURLSessionDataTask *)POST:(NSString *)url params:(void (^)(NSMutableDictionary *))setParamsBlock success:(void (^)(id))success failure:(void (^)(NSInteger, NSString *))failure error:(void (^)(NSError *))errorCall
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    setParamsBlock?setParamsBlock(parameters):NULL;
    _LNSessionManager *manager = [_LNSessionManager _lnsessionManager];
    return [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 0) {
            success?success(responseObject):NULL;
        }else{
            failure?failure(code, [responseObject objectForKey:@"rtnInfo"]):NULL;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorCall?errorCall(error):NULL;
    }];
}
@end

@implementation UIViewController (LNNetwork)
- (void)setCancleNetRequestWhenDisAppear
{
    Method sysm = class_getInstanceMethod(self.class, @selector(viewDidDisappear:));
    Method m = class_getInstanceMethod(self.class, @selector(zy_viewDidDisappear:));
    method_exchangeImplementations(sysm, m);
}

- (void)zy_viewDidDisappear:(BOOL)animated
{
    [self zy_viewDidDisappear:animated];
    
    // 取消网络请求
    [self cancleRequest];
}

- (void)cancleRequest
{
    // 取消网络请求
    for (NSURLSessionTask *task in [self requests]) {
        [task cancel];
    }
}

- (NSPointerArray *)requests
{
    NSPointerArray *_requests = objc_getAssociatedObject(self, _cmd);
    if (_requests == nil) {
        _requests = [NSPointerArray weakObjectsPointerArray];
        objc_setAssociatedObject(self, _cmd, _requests, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _requests;
}

- (NSMutableDictionary *)setting
{
    NSMutableDictionary *setting = objc_getAssociatedObject(self, _cmd);
    if (setting == nil) {
        setting = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, setting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return setting;
}

- (NSURLSessionTask *)POST:(NSString *)url  params:(void (^)(NSMutableDictionary *params, LNNetworkManagerConfig *config))setParamsBlock success:(void (^)(id json))success failure:(void (^)(NSInteger code, NSString *info))failure error:(void (^)(NSError *error))errorCall
{
    
    LNNetworkManagerConfig *config = [LNNetworkManagerConfig new];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    setParamsBlock?setParamsBlock(params, config):nil;
    if (config.autoHud) {
        // 如果有刷新控件,只loading一次
        if (config.header) {
            if ([[self setting] objectForKey:url] == nil) {
                [self showLoading];
            }
        }
        // 重复loading
        else{
            [self showLoading];
        }
        [[self setting] setObject:@YES forKey:url];
    }
    
  
    _LNSessionManager *session = [_LNSessionManager _lnsessionManager];
    session.requestSerializer.timeoutInterval = config.timeout?config.timeout:10;
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionTask *task = [session POST:url parameters:params progress:nil success:^(NSURLSessionDataTask *task, id json) {
        if (task == nil) {
            config.autoHud?[weakSelf dismiss]:NULL;
            config.header?[config.header endRefreshing]:NULL;
            config.footer?[config.footer endRefreshing]:NULL;
            return;
        }
        NSInteger code = [[json objectForKey:@"code"] integerValue];
        if (code == 0) {
            config.autoHud?[weakSelf dismiss]:NULL;
            config.header?[config.header endRefreshing]:NULL;
            config.footer?[config.footer endRefreshing]:NULL;
            success?success(json):NULL;
        }else{
            config.autoHud?[weakSelf showInfo:[json objectForKey:@"rtnInfo"]]:NULL;
            config.header?[config.header endRefreshing]:NULL;
            config.footer?[config.footer endRefreshing]:NULL;
            failure?failure(code, [json objectForKey:@"rtnInfo"]):NULL;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (task == nil) {
            config.autoHud?[weakSelf dismiss]:NULL;
            config.header?[config.header endRefreshing]:NULL;
            config.footer?[config.footer endRefreshing]:NULL;
            return;
        }
        if (config.retryCount > 0) {
            config.retryCount--;
            [task resume];
        }else{
            config.autoHud?[weakSelf showError]:NULL;
            config.header?[config.header endRefreshing]:NULL;
            config.footer?[config.footer endRefreshing]:NULL;
            errorCall?errorCall(error):NULL;
        }
    }];
   // 保存所有请求的任务
    if (task) {
        [[self requests] addPointer:(__bridge void *)task];
    }
    return task;
}

@end




@implementation _LNSessionManager
static NSString *const _BASE_URL_STRING = @"BASEURL";
+ (instancetype)_lnsessionManager
{
    static dispatch_once_t once;
    static id instance ;
    dispatch_once(&once, ^{
        _LNSessionManager *manager = [[_LNSessionManager alloc]init];
        if (_BASE_URL_STRING.length) {
             manager = [[_LNSessionManager alloc]initWithBaseURL:[NSURL URLWithString:_BASE_URL_STRING]];
        }
        manager.requestSerializer.timeoutInterval = 10;
        instance = manager;
    });
    return instance;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress *))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    // 1、判断用户是否登录、判断url地址等是否符合要求
    // 2、处理参数，对参数进行处理（后台规则：加字段，加类型等）加密等（MD5等防止被拦截篡改）
     super.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
    return [super POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];
}

@end
