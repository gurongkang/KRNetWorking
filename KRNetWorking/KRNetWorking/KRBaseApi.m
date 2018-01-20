//
//  KRBaseApi.m
//  KRNetWorking
//
//  Created by RK on 2018/1/20.
//  Copyright © 2018年 RK. All rights reserved.
//

#import "KRBaseApi.h"

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

@implementation KRBaseApi

@end
