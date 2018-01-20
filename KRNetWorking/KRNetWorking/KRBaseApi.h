//
//  KRBaseApi.h
//  KRNetWorking
//
//  Created by RK on 2018/1/20.
//  Copyright © 2018年 RK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KRSuccess)(id response);
typedef void(^KRFailure)(NSError *error);

@interface KRBaseApiConfig : NSObject

/**
 *  DEBUG模式下，是否打印请求url
 *  @warning 此参数仅在DEBUG模式下可以打开，RELEASE模式下设置此参数无效
 */
@property (nonatomic, assign) BOOL printUrl;

/**
 是否启用加载菊花 YES 是 NO否
 */
@property (nonatomic, assign) BOOL enableLoading;

@end

@interface KRBaseApi : NSObject

/**
 *  配置Api，每一个从BaseApi衍生的子类实例，都可以单独设定config来获得实例级别的单独配置
 */
@property (nonatomic, strong) KRBaseApiConfig *config;

/**
 请求地址
 */
@property (nonatomic, copy) NSString *apiHost;

/**
 请求url
 */
@property (nonatomic, copy) NSString *apiUrl;

/**
 公共参数
 */
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> *publicParams;

+ (instancetype)api;

/**
 http get 请求
 
 @param url 请求
 @param parameters 参数
 @param krSuccess 成功回调
 @param krFailure 失败回调
 */
- (void)httpGet:(NSString *)url
     parameters:(NSDictionary *)parameters
        success:(KRSuccess)krSuccess
        failure:(KRFailure)krFailure;

/**
 http get 请求
 
 @param url 请求
 @param parameters 参数
 @param isShow 是否加载菊花
 @param krSuccess 成功回调
 @param krFailure 失败回调
 */
- (void)httpGet:(NSString *)url
     parameters:(NSDictionary *)parameters
    showLoading:(BOOL)isShow
        success:(KRSuccess)krSuccess
        failure:(KRFailure)krFailure;

/**
 http post 请求
 
 @param url 请求
 @param parameters 参数
 @param krSuccess 成功回调
 @param krFailure 失败回调
 */
- (void)httpPost:(NSString *)url
      parameters:(NSDictionary *)parameters
         success:(KRSuccess)krSuccess
         failure:(KRFailure)krFailure;

/**
 http post 请求
 
 @param url 请求
 @param parameters 参数
 @param isShow 是否加载菊花
 @param krSuccess 成功回调
 @param krFailure 失败回调
 */
- (void)httpPost:(NSString *)url
      parameters:(NSDictionary *)parameters
     showLoading:(BOOL)isShow
         success:(KRSuccess)krSuccess
         failure:(KRFailure)krFailure;

@end
