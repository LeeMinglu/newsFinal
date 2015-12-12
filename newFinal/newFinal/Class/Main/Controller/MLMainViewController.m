//
//  MLMainViewController.m
//  newFinal
//
//  Created by 李明禄 on 15/12/8.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLMainViewController.h"
#import "MLChannel.h"
#import "MLHeadLineViewController.h"
#import "MLHomeLabel.h"

@interface MLMainViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray *channelList;

@end

@implementation MLMainViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.channelList);
    
    //1.加载子控制器
    [self setupChildControllers];
    
    //2.添加顶部的所有标题
    [self setupTitles];
    
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
    
    
    //循环添加子控制器
    NSUInteger count = self.channelList.count - 1; //(-1 说明 控制器已经创建了1个控制器)
    
    for (NSUInteger i = 1; i < count; i++) {
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






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
