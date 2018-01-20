//
//  NSURL+KR.h
//  KRNetWorking
//
//  Created by RK on 2018/1/20.
//  Copyright © 2018年 RK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (KR)

/**
 将传入的字典进行urlencode并转换为query string
 
 @param dictionary 参数字典
 @return query string
 */
+ (NSString *)kr_queryStringFromDictionry:(NSDictionary *)dictionary;

/**
 url编码
 
 @param string 要编码字符串
 @return 编码好的字符串
 */
+ (NSString *)kr_urlEncode:(NSString *)string;


/**
 获取url对应的key 因为签名是动态的
 
 @param url url地址
 @return key
 */
+ (NSString *)kr_keyForUrl:(NSString *)url params:(NSDictionary *)params;

@end
