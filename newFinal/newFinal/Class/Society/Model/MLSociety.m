//
//  MLSociety.m
//  newFinal
//
//  Created by 李明禄 on 15/12/16.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLSociety.h"

@implementation MLSociety

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)societyWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

// 重写,什么都不做,防止字典转模型奔溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
