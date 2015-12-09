//
//  MLAdViewController.m
//  newFinal
//
//  Created by 李明禄 on 15/12/8.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLAdViewController.h"
#import "MLMainTabBarController.h"

//定义广告出现的时间
#define AdTime 3.0

//广告背景图片名字
#define AdBackgroundPictureName @"Default"
//广告图片名字
#define AdPictureName @"ad"



@interface MLAdViewController ()

@end

@implementation MLAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置背景图片
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:AdBackgroundPictureName]];
    [self.view addSubview:backgroundImageView];
    backgroundImageView.frame = self.view.bounds;
    
    //2.设置广告图片
    UIImageView *adImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:AdPictureName]];
    [self.view addSubview:adImageView];
    
    //设置frame
//        设置图片原本的宽高
    adImageView.width = 306;
    adImageView.height = 310;
    adImageView.centerX = self.view.centerX;
    adImageView.centerY = self.view.height * 0.4;
    
//    3.广告之后，获取到主窗口，跳到MainTabbar
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AdTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //1.获取到主窗口
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        //2.初始化MainTabBar控制器
        MLMainTabBarController *mainTabBarVC = [[MLMainTabBarController alloc] init];
        //3.将MainTabBar控制器作为根控制器
        window.rootViewController = mainTabBarVC;
    
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
