//
//  MLMainTabBarController.m
//  newFinal
//
//  Created by 李明禄 on 15/12/8.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLMainTabBarController.h"
#import "MLNavigationViewController.h"

//tabbar子控制器
#import "MLMainViewController.h"
#import "MLReadingViewController.h"
#import "MLDiscoverViewController.h"
#import "MLVideoViewController.h"
#import "MLMeViewController.h"

//view
#import "MLBottomTabBar.h"
#import "MLBottomTabBarButton.h"

@interface MLMainTabBarController ()<MLBottomTabBarDelegate>

@end

@implementation MLMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化子控制器
    [self setupChildController];
    
    //初始化底部自定义tabbar
    [self setupCustomTabBar];
}

/**
 *  初始化子控制器
 */
- (void)setupChildController {
    //1.新闻中心
    MLNavigationViewController *navMainHall = [self navigationControllerWithStoryBoardName:@"Main"];
    
    //2.阅读中心
    MLNavigationViewController *navReadHall = [self navigationControllerWithStoryBoardName:@"Reading"];
    
    //3.发现
    MLNavigationViewController *navDiscoverHall = [self navigationControllerWithStoryBoardName:@"Discover"];
    
    //4.视频中心
    MLNavigationViewController *navVideoHall = [self navigationControllerWithStoryBoardName:@"Video"];
    
    //5.我
    MLNavigationViewController *navMeHall = [self navigationControllerWithStoryBoardName:@"Me"];

    //6.将上面的控制器添加到MLMainTabBarController中
    self.viewControllers = @[navMainHall, navReadHall, navDiscoverHall, navVideoHall, navMeHall];
}

/**
 *  初始化自定义底部tabBar
 */
- (void)setupCustomTabBar {
    //1.创建自定义的tabbar
    MLBottomTabBar *tabBar = [[MLBottomTabBar alloc] init];
    
    //2.通过循环来创建若干个tabbarbutton(自定义button按钮)
    //这里的数量是通过控制器的数量来获取的
    NSUInteger count = self.viewControllers.count;
    for (NSUInteger i = 0; i < count; i++) {
        //获取普通图片和选中图片的名称
        NSString *normal = [NSString stringWithFormat:@"TabBar%td",(i + 1)];
        NSString *selected = [NSString stringWithFormat:@"TabBar%tdSel",(i + 1)];
        
        //调用内部封装的方法来快速创建自定义tabBarButton
        [tabBar addButtonWithImage:normal selected:selected];
    }
    
    //3.设置frame并添加当前的tabBar中
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
    //4.设置代理；
    tabBar.delegate = self;

    
    
}



- (MLNavigationViewController *) navigationControllerWithStoryBoardName:(NSString *) storyBoardName {
    
    //1.加载storyBoard文件
    UIStoryboard  *storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    
    //2.创建storyBoard中箭头指向的初始化服务器
    return [storyBoard instantiateInitialViewController];

}



#pragma mark 实现tabBar代理的方法
- (void)buttonTabBar:(MLBottomTabBar *)tabBar didClickButtonTabBarWithIndex:(NSUInteger)index {
     // 让UITabBarController自己来切换需要显示的子控制器 selectedIndex是系统内部自己的属性
    self.selectedIndex = index;
}

@end
