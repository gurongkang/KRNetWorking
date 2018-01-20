//
//  KRBaseApi.m
//  KRNetWorking
//
//  Created by RK on 2018/1/20.
//  Copyright © 2018年 RK. All rights reserved.
//

#import "KRBaseApi.h"

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

@implementation KRBaseApi



@end
