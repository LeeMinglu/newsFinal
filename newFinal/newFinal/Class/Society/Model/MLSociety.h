//
//  MLSociety.h
//  newFinal
//
//  Created by 李明禄 on 15/12/16.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLSociety : NSObject

/** 新闻标题 */
@property (nonatomic , copy) NSString *title;
/** 新闻摘要 */
@property (nonatomic , copy) NSString *digest;
/** 图片 */
@property (nonatomic , copy) NSString *imgsrc;
/** 新闻id */
@property (nonatomic , copy) NSString *docid;

/** 跟帖数量 */
@property (nonatomic,assign) int replyCount;

/** 是否为头部标题, 如果是第一条, 那么返回值就是 1 */
@property (nonatomic,assign) BOOL hasHead;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)societyWithDict:(NSDictionary *)dict;

@end
