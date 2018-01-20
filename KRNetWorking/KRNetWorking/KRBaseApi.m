//
//  KRBaseApi.m
//  KRNetWorking
//
//  Created by RK on 2018/1/20.
//  Copyright © 2018年 RK. All rights reserved.
//

#import "KRBaseApi.h"
#import "NSURL+KR.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <APToast/UIView+APToast.h>

@implementation KRBaseApiConfig

+ (instancetype)config {
    KRBaseApiConfig *config = [[self class]new];
    return config;
}

- (instancetype)init {
    if (self = [super init]) {
        self.printUrl = NO;
    }
    return self;
}

- (void)setPrintUrl:(BOOL)printUrl {
#if DEBUG
    _printUrl = printUrl;
#else
    _printUrl = NO;
#endif
}

@end

@interface KRBaseApi()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation KRBaseApi

+ (instancetype)api {
    id api = [[self class] new];
    return api;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [_sessionManager.requestSerializer setTimeoutInterval:8];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _config = [KRBaseApiConfig config];
    }
    return self;
}

- (NSDictionary *)buildParameters:(NSDictionary *)parameters {
     return [NSDictionary dictionary];
}

- (void)httpGet:(NSString *)url
     parameters:(NSDictionary *)parameters
    showLoading:(BOOL)isShow
        success:(KRSuccess)krSuccess
        failure:(KRFailure)krFailure {
    self.config.enableLoading = isShow;
    [self httpGet:url parameters:parameters success:krSuccess failure:krFailure];
}

- (void)httpGet:(NSString *)url
     parameters:(NSDictionary *)parameters
        success:(KRSuccess)krSuccess
        failure:(KRFailure)krFailure {
    if (!url.length)
        return;
    
    if (self.config.enableLoading) {
        [MBProgressHUD showHUDAddedTo: [UIApplication sharedApplication].keyWindow animated:YES];
    }
    
    [_sessionManager GET:self.fullUrl parameters:[self buildParameters:parameters] progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        
        if (krSuccess) {
            if (self.config.enableLoading) {
                [MBProgressHUD hideHUDForView: [UIApplication sharedApplication].keyWindow animated:YES];
            }
            
            krSuccess(responseObject);
            
            [self printResponse:responseObject url:url paramters:parameters];
            
        }
    }            failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (self.config.enableLoading) {
            [MBProgressHUD hideHUDForView: [UIApplication sharedApplication].keyWindow animated:YES];
        }
        if (krFailure) {
            [[UIApplication sharedApplication].keyWindow ap_makeToast:@"网络请求出错"];
            krFailure(error);
        }
    }];
}

- (void)httpPost:(NSString *)url
      parameters:(NSDictionary *)parameters
     showLoading:(BOOL)isShow
         success:(KRSuccess)krSuccess
         failure:(KRFailure)krFailure{
    self.config.enableLoading = isShow;
    [self httpPost:url parameters:parameters success:krSuccess failure:krFailure];
}

- (void)httpPost:(NSString *)url
      parameters:(NSDictionary *)parameters
         success:(KRSuccess)krSuccess
         failure:(KRFailure)krFailure {
    
    if (!url.length)
        return;
    self.apiUrl = url;
    
    if (self.config.enableLoading) {
        [MBProgressHUD showHUDAddedTo: [UIApplication sharedApplication].keyWindow animated:YES];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self printUrl:self.fullUrl paramters:parameters];
        
        [_sessionManager POST:self.fullUrl parameters:[self buildParameters:parameters] progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            
            //加载菊花
            if (self.config.enableLoading) {
                [MBProgressHUD hideHUDForView: [UIApplication sharedApplication].keyWindow animated:YES];
            }
            
            //返回请求值
            if (krSuccess) {
                krSuccess(responseObject);
            }
            
            //打印请求
            [self printResponse:responseObject url:url paramters:parameters];
            
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            if (self.config.enableLoading) {
                [MBProgressHUD hideHUDForView: [UIApplication sharedApplication].keyWindow animated:YES];
            }
            
            if (krFailure) {
                krFailure(error);
            }
        }];
    });
}


/**
 打印请求
 
 @param url 请求url
 */
- (void)printUrl:(NSString *)url paramters:(NSDictionary *)paramters{
    if (self.config.printUrl) {
        NSString *queryStr = [NSURL kr_queryStringFromDictionry:paramters];
        NSString *fullUrl = [NSString stringWithFormat:@"%@?%@", url, queryStr];
        NSLog(@"请求 %@", fullUrl);
    }
}

/**
 打印返回值
 
 @param response 返回
 @param url 请求url
 */
- (void)printResponse:(id)response url:(NSString *)url paramters:(NSDictionary *)paramters{
    if (self.config.printUrl) {
        NSString *queryStr = [NSURL kr_queryStringFromDictionry:paramters];
        NSString *fullUrl = [NSString stringWithFormat:@"%@?%@", url, queryStr];
        NSLog(@"%@ 返回值 %@",fullUrl, response);
    }
}

@end
