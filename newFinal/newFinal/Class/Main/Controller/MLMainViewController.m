//
//  MLMainViewController.m
//  newFinal
//
//  Created by 李明禄 on 15/12/8.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

//宏定义
#define navLeftBarBtnItemImgName @"sidebar_nav_news"

#import "MLMainViewController.h"
#import "MLChannel.h"
#import "MLHeadLineViewController.h"
#import "MLSocietyViewController.h"
#import "MLHomeLabel.h"
#import "MLLeftDockMenu.h"

@interface MLMainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray *channelList;

@property (nonatomic, weak) MLLeftDockMenu *leftDockMenu;

@end

@implementation MLMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MLLog(@"%@",self.channelList);
    
    //1.加载子控制器
    [self setupChildControllers];
    
    //2.添加顶部的所有标题
    [self setupTitles];
    
    //3.设置titleScrollView的属性
    [self setupScrollViewProperty];
    
    //4.添加默认控制器
    [self defaultController];
    
    //5.设置默认Label的比例值
    MLHomeLabel *firstLabel = [self.titleScrollView.subviews firstObject];
    firstLabel.scale = 1.0;
    
    //6.设置导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:navLeftBarBtnItemImgName] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftItemClick)];
    
}

/**
 *  点击导航栏左边的按钮
 */
- (void)navLeftItemClick {
   //1.如果左边的视图已经存在说明不是第一次点击，需要进行判断是展开还是开闭
    if (self.leftDockMenu) {
        //左边视图菜单为展开状态
       
        if (self.contentScrollView.contentOffset.x < 0) {//需要闭合

            [self.contentScrollView setContentOffset:CGPointZero animated:YES];
            
        }else {//需要展开
            //让内容视图向右滚动200的间距
            [self.contentScrollView setContentOffset:CGPointMake(-200, 0) animated:YES];
         }
    }else { //2.如果左侧视图不存在，说明是第一次点击，创建左侧视图
        [self setupLeftDockMenu];
        [self.contentScrollView setContentOffset:CGPointMake(-200, 0) animated:YES];
        
    }
    

}

/**
 *  创建左侧视图
 */
- (void)setupLeftDockMenu {
    
    //1.创建左边的菜单视图
    MLLeftDockMenu *leftDockMenu = [[MLLeftDockMenu alloc] init];
    leftDockMenu.height = 300;
    leftDockMenu.width = 150;
    leftDockMenu.y = (self.contentScrollView.height - leftDockMenu.height) * 0.5;
    leftDockMenu.x = -200;
    
    //2.将视图添加到滚动视图中
    [self.contentScrollView addSubview:leftDockMenu];
    
    //3.记录左边的视图
    self.leftDockMenu = leftDockMenu;
    
}



/**
 *  设置默认控制器
 */
- (void)defaultController {
    MLHeadLineViewController *defaultVC = (MLHeadLineViewController *)[self.childViewControllers firstObject];
    [self.contentScrollView addSubview:defaultVC.view];
#warning 这里没有设置frame()，contentView中显示的内容
    defaultVC.view.frame = self.contentScrollView.bounds;
    
}


/**
 *  添加子控制器
 */
- (void)setupChildControllers {
    
    //1.添加新闻控制器
    MLHeadLineViewController *headLineVC = (MLHeadLineViewController *)[self viewControllerWithName:@"HeadLine"];
    
    // 传递url字符串 -> 用来发送请求
    headLineVC.urlString = [self.channelList[0] tid];
    
    //设置控制器的title
    headLineVC.title = [self.channelList[0] tname];
    
    //添加子控制器
    [self addChildViewController:headLineVC];
    
    
    //2.添加社会控制器
    MLSocietyViewController *societyVC = (MLSocietyViewController *)[self viewControllerWithName:@"Society"];
    
    // 传递url字符串 -> 用来发送请求
    societyVC.urlString = [self.channelList[1] tid];
    
    //设置控制器的title
    societyVC.title = [self.channelList[1] tname];
    
    //添加子控制器
//    [self addChildViewController:societyVC];
    
    
    //循环添加子控制器
    NSUInteger count = self.channelList.count - 2; //(-1 说明 控制器已经创建了1个控制器)
    
    for (NSUInteger i = 2; i < count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        
        vc.title = [self.channelList[i] tname];
        
        [self addChildViewController:vc];
    }
    
}

/**
 *  添加顶部的所有标题
 */
- (void)setupTitles {
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat w = 80;
    CGFloat h = 30;
    CGFloat y = 0;
    
    for (int i = 0; i < count; i++) {
        //1.创建Label
        MLHomeLabel *label = [[MLHomeLabel alloc] init];
        label.tag = i;
        [self.titleScrollView addSubview:label];
        
        //2.设置Frame
        CGFloat x = i * w;
        label.frame = CGRectMake(x, y, w, h);
        
        //3，设置文字
        label.text = self.childViewControllers[i].title;
        
        //4.监听点击
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        
        //5.设置scrollView的大小
        CGFloat titleContentW = count * w;
        self.titleScrollView.contentSize = CGSizeMake(titleContentW, 0);
    }
    
    
}

/**
 *  设置scrollView的属性
 */
- (void)setupScrollViewProperty {
    
    //1.取消水平和垂直滚动条, 否则会报 [UIImageView setScale:] 找不到方法!
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    //2.设置分布效果
    self.contentScrollView.pagingEnabled = YES;
    
    //3.设置内容滚动视图的size
    CGFloat contentW = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.contentScrollView.contentSize = CGSizeMake(contentW, 0);
    
    //4.设置scrollView的代理方法
    self.contentScrollView.delegate = self;
    
    //5.取消scrollView自动调整内边距的属性(如果没有这句代码出现内容在界面上上移的现象)
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

/**
 *  通过storyBoard生成控制器
 *
 *  @param name storyBoardName 与 标识符 必须相同
 *
 *  @return 生成的控制器
 */
- (UIViewController *)viewControllerWithName:(NSString *)name {
    UIStoryboard *HeadLineStoryBoard = [UIStoryboard storyboardWithName:name bundle:nil];
    
    return  [HeadLineStoryBoard instantiateViewControllerWithIdentifier:name];
}


/**
 *  点击标签事件
 *
 *  @param recognizer <#recognizer description#>
 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer {
    //1.获得被点击的label
    MLHomeLabel *label =(MLHomeLabel *)recognizer.view;
    
    //2.计算x位置上的偏移量
    CGFloat offSetX = label.tag * self.contentScrollView.frame.size.width;
    
    //3.设置content的偏移量
    [self.contentScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    
}

#pragma mark 实现UIScrollView的代理方法


#pragma mark 懒加载频道数组
- (NSArray *)channelList {
    if (!_channelList) {
        
        //1.加载JSON数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        //2.对数进行反序列化
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
        
        //3.从字典中获取字典数据
        NSArray *dictarray = dict[dict.keyEnumerator.nextObject];
        NSMutableArray *arrModel = [NSMutableArray array];
        
        //4.将字典转化成模型
        for (NSDictionary *dict in dictarray) {
            MLChannel *channel = [MLChannel channelWithDict:dict];
            
            [arrModel addObject:channel];
        }
        
        //5.返回从小到大的数据，tid是从小到大排列的
        
        _channelList = [arrModel sortedArrayUsingComparator:^NSComparisonResult(MLChannel *obj1, MLChannel *obj2) {
            return [obj1.tid compare:obj2.tid];
        }];
    }
    
    return _channelList;
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  在scrollview动画结束时调用 (添加子控制器的view到 self.contentScrollview )
 *
 *  @param scrollView == self.contentScrollview
 *  用户手动触发的动画结束,不会调用这个方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewDidEndScrollingAnimation");
    
    // 获得当前需要显示的子控制器索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIViewController *vc = self.childViewControllers[index];
    
    // 滚动标题栏 (self.titleScrollview)
    MLHomeLabel *label = self.titleScrollView.subviews[index];
    CGFloat width = self.titleScrollView.frame.size.width;
    CGFloat offsetX = label.center.x - width * 0.5;
    // 最大偏移量
    CGFloat maxOffsetx = self.titleScrollView.contentSize.width - width;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > maxOffsetx) {
        offsetX = maxOffsetx;
    }
    //    self.titleScrollView.contentOffset = CGPointMake(offsetX, 0);
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    // 遍历其它的label
    [self.titleScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            MLHomeLabel *otherLabel = self.titleScrollView.subviews[idx];
            otherLabel.scale = 0.0;
            
        }
    }];
    
    // 如果子控制器的view已经在上面,就直接返回
    if (vc.view.superview) return;
    
    // 添加
    CGFloat vcW = scrollView.frame.size.width;
    CGFloat vcH = scrollView.frame.size.height;
    CGFloat vcY = 0;
    CGFloat vcX = index * vcW;
    
    
    
    vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
    
    [scrollView addSubview:vc.view];
}
/**
 *  当scrollview停止滚动时调用这个方法 (用户手动触发的动画结束,会调用这个方法)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1. 需要进行控制的文字 (2个标题)
    // 2. 两个标题各自的比例值
#warning 这里最好取绝对值 (保证计算出来的比例是个非负数)
    // 偏移量 / 宽度
    CGFloat value = ABS(self.contentScrollView.contentOffset.x / self.contentScrollView.frame.size.width);
    
    //    NSLog(@"%f",value);
    
    // 左边文字的索引
    NSUInteger leftIndex = (NSUInteger)value;
    // 右边文字的索引
    NSUInteger rightIndex = leftIndex + 1;
    
    // 右边文字的比例
    CGFloat rightScale = value - leftIndex;
    // 左边文字的比例
    CGFloat leftScale = 1 - rightScale;
    
    // 取出label设置大小和颜色
    MLHomeLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    leftLabel.scale = leftScale;
    if (rightIndex < self.titleScrollView.subviews.count) {
        MLHomeLabel *rightLabel = self.titleScrollView.subviews[rightIndex];
        rightLabel.scale = rightScale;
    }
}


@end
