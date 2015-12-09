//
//  MLBottmTabBar.m
//  newFinal
//
//  Created by 李明禄 on 15/12/8.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLBottomTabBar.h"
#import "MLBottomTabBarButton.h"

@interface MLBottomTabBar ()

@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation MLBottomTabBar

- (void)addButtonWithImage:(NSString *)normal selected:(NSString *)selected {
    //1.创建一个按钮
    MLBottomTabBarButton *button = [[MLBottomTabBarButton alloc] init];
    
    //2.设置背景图片
    [button setBackgroundImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    
    //3.把按钮添加到底部的tabbar中
    [self addSubview:button];
    
    //4.为按钮绑定一个点击事件
    [button addTarget:self action:@selector(didClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
}

- (void)didClickTabBarButton:(UIButton *)button {
    //1.让当前被选中的按钮的选中状态设置为取消选中状态
    self.selectedButton.selected = NO;
    
    //2.设置传进来的按钮为选中状态；
    button.selected = YES;
    
    //3.记录当前传进来的按钮为当前选中的按钮
    self.selectedButton = button;
    
    //4.获取当前被点击的按钮的索引，调用代理的协议方法，让tabBarController来切换当前显示的子控制器
    NSUInteger index = button.tag;
    
    if ([self.delegate respondsToSelector:@selector(buttonTabBar:didClickButtonTabBarWithIndex:)]) {
        [self.delegate buttonTabBar:self didClickButtonTabBarWithIndex:index];
    }
}


//布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //获取总按钮的个数
    NSUInteger count = self.subviews.count;
    
    //设置frame
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    CGFloat y = 0;
    
    for (NSUInteger i = 0; i < count; i++) {
        
        CGFloat x = i * w;
        
        //获取对应的按钮，设置frame
        UIButton *button = self.subviews[i];
        button.frame = CGRectMake(x, y, w, h);
        
        button.tag = i;
        
        
        if (i == 0) {
            button.selected = YES;
            self.selectedButton = button;
        }
    }
}

@end
