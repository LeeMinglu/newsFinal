//
//  MLSocietyCell.h
//  高仿网易新闻案例
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLSociety;

@interface MLSocietyCell : UITableViewCell

/** 数据模型属性 */
@property (nonatomic, strong) MLSociety *society;

/** 根据创建的模型来返回相对应的cell重用标识符 */
+ (NSString *)societyCellWithIdentifier:(MLSociety *)society;

@end
