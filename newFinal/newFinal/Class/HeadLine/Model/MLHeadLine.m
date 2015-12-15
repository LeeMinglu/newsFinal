//
//  MLHeadLine.m
//  newFinal
//
//  Created by 李明禄 on 15/12/13.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLHeadLine.h"

@implementation MLHeadLine

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)headlineWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}


@end
