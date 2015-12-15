//
//  MLHeadLine.h
//  newFinal
//
//  Created by 李明禄 on 15/12/13.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLHeadLine : NSObject
/**新闻标题*/
@property (nonatomic, copy) NSString *title;

/**新闻摘要*/
@property (nonatomic, copy) NSString *digest;

/**图片*/
@property (nonatomic, copy) NSString *imgsrc;

/**新闻id*/
@property (nonatomic, copy) NSString *docid;

/**跟帖数量*/
@property (nonatomic, assign) int replyCount;

/**多图数据（两张）*/
@property (nonatomic, strong) NSArray *imgextra;

/**添加一个图片类型属性，如果是大图，那么数据就为1 */
@property (nonatomic, assign, getter = isBigImage) BOOL imgType;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)headlineWithDict:(NSDictionary *)dict;

@end
