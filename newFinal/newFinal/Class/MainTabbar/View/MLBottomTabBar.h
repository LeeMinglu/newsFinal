//
//  MLBottmTabBar.h
//  newFinal
//
//  Created by 李明禄 on 15/12/8.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLBottomTabBar;


@protocol MLBottomTabBarDelegate <NSObject>

@optional
// 设置协议 - 将自定义内部被点击的按钮索引传给tabBarController.进行切换控制器
- (void)buttonTabBar:(MLBottomTabBar *)tabBar didClickButtonTabBarWithIndex:(NSUInteger)index;
@end

@interface MLBottomTabBar : UIView

- (void)addButtonWithImage:(NSString *)normal selected:(NSString *)selected;

@property (nonatomic, weak) id<MLBottomTabBarDelegate> delegate;

@end
