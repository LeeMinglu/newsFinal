//
//  MLMainViewController.m
//  newFinal
//
//  Created by 李明禄 on 15/12/8.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLMainViewController.h"
#import "MLChannel.h"

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
