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

@interface MLMainTabBarController ()

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
    
}

- (MLNavigationViewController *) navigationControllerWithStoryBoardName:(NSString *) storyBoardName {
    
    //1.加载storyBoard文件
    UIStoryboard  *storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    
    //2.创建storyBoard中箭头指向的初始化服务器
    return [storyBoard instantiateInitialViewController];

}

@end
