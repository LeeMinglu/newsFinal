//
//  MLChannel.m
//  newFinal
//
//  Created by 李明禄 on 15/12/11.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLChannel.h"

@implementation MLChannel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)channelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
