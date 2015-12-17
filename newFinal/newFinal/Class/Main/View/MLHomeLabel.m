//
//  MLHomeLabel.m
//  newFinal
//
//  Created by 李明禄 on 15/12/10.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLHomeLabel.h"

@implementation MLHomeLabel

//初始化initWithFrame
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super  initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:20];
        self.scale = 0.0;
    }
    
    return self;
}

//重写scale的setter方法
- (void)setScale:(CGFloat)scale {
    _scale = scale;
    
    
#warning 定义的宏是否正确，有待验证
    // 颜色渐变
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1.0];

    
    //设置label字体的大小
    CGFloat defaultScale = 0.6;
    CGFloat finalscale = defaultScale + scale * (1 - defaultScale);
    
    self.transform = CGAffineTransformMakeScale(finalscale, finalscale);
    
    
}


@end
