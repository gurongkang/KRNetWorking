//
//  NSURL+KR.m
//  KRNetWorking
//
//  Created by RK on 2018/1/20.
//  Copyright © 2018年 RK. All rights reserved.
//

#import "NSURL+KR.h"

@implementation NSURL (KR)

+ (NSString *)kr_queryStringFromDictionry:(NSDictionary *)dictionary {
    if (!dictionary.count) {
        return nil;
    }
    
    NSArray *query;
    if (dictionary.count > 0) {
        NSMutableArray *params = [NSMutableArray array];
        for (NSString *key in dictionary.allKeys) {
            NSString *value = [self stringFromObject:dictionary[key]];
            if (!value) {
                [params addObject:key];
            } else {
                [params addObject:[NSString stringWithFormat:@"%@=%@", key, [self kr_urlEncode:value]]];
            }
        }
        query = [params sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2];
        }];
    }
    return [query componentsJoinedByString:@"&"];
}

+ (NSString *)kr_urlEncode:(NSString *)string {
    NSString *result = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef) string, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    return result;
}

+ (NSString *)kr_keyForUrl:(NSString *)url params:(NSDictionary *)params {
    NSString *key = [NSString stringWithFormat:@"%@%@", url, [self kr_queryStringFromDictionry:params]];
    return key;
}

+ (NSString *)stringFromObject:(id)obj {
    NSString *str = nil;
    if ([obj isKindOfClass:[NSString class]]) {
        str = obj;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        str = [obj stringValue];
    }
    return str;
}

@end
