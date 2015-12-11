//
//  MLChannel.h
//  newFinal
//
//  Created by 李明禄 on 15/12/11.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLChannel : NSObject

@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *tname;


- (instancetype)initWithDict:(NSDictionary *) dict;
+ (instancetype)channelWithDict:(NSDictionary *)dict;

@end
