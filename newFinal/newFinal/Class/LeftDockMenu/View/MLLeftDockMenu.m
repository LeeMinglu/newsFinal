//
//  MLLeftDockMenu.m
//  newFinal
//
//  Created by 李明禄 on 15/12/12.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLLeftDockMenu.h"
#define LeftMenuBtnFont 18

@implementation MLLeftDockMenu

#pragma mark   一创建的时候就被初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MLRandomColor;
        
        //创建子控件
        [self setupBtnWithIcon:@"sidebar_nav_news" title:@"新闻"];
        [self setupBtnWithIcon:@"sidebar_nav_reading" title:@"订阅"];
        [self setupBtnWithIcon:@"sidebar_nav_photo" title:@"图片"];
        [self setupBtnWithIcon:@"sidebar_nav_video" title:@"视频"];
        [self setupBtnWithIcon:@"sidebar_nav_comment" title:@"跟帖"];
        [self setupBtnWithIcon:@"sidebar_nav_radio" title:@"电台"];
        
    }
    return self;
}


///添加按钮
- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title {
    
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = MLRandomColor;
#warning  这里需要注意下，为什么是self.subviews.count
    btn.tag = self.subviews.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    //设置图片和文字
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:LeftMenuBtnFont];
    
    //设置背景颜色
    btn.backgroundColor = MLRandomColor;
    
    //设置按钮内容左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    //设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    return btn;
}

///布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width;
    CGFloat btnH = self.height / btnCount;
    
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = i * btnH;
        btn.tag = i;
    }
    

}

- (void)buttonClick:(UIButton *)button {
    MLLog(@"需要发送通知");
//    button addObserver:<#(nonnull NSObject *)#> forKeyPath:<#(nonnull NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(nullable void *)#>
}





@end
