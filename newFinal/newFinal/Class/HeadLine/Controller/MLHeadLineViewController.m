//
//  MLHeadLineViewController.m
//  newFinal
//
//  Created by 李明禄 on 15/12/12.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLHeadLineViewController.h"
#import "MLHTTPManager.h"
#import "MLHeadLineCell.h"
#import "MBProgressHUD+MLExtension.h"
#import "MLHeadLine.h"
#import "MLNewsDetailViewController.h"



@interface MLHeadLineViewController ()

//存放模型的数组
@property (nonatomic, strong) NSArray *headlines;
@end

@implementation MLHeadLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     /********* 发送请求,加载数据 *********/
    
    
    // @"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html"
    //根据域名发送请求数据
    NSString *domainURL = [kNetEaseDomain stringByAppendingString:self.urlString];
    
    domainURL = [NSString stringWithFormat:@"%@/0-140.html",domainURL];
    
    //向服务器端发送请求
    [[MLHTTPManager manager] GET:domainURL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //成功回调, 这里需要设置responseObject的类型为NSDictionary
        //可以将返回来的数据写成plist文件进行查看
        
//        [responseObject writeToFile:@"/Users/luoriver/Desktop/luo.plist" atomically:YES];
        
        NSArray *dictArray = responseObject[self.urlString];
        NSMutableArray *arrModel = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            MLHeadLine *headline = [MLHeadLine headlineWithDict:dict];
            [arrModel addObject:headline];
        }
        
        self.headlines = arrModel;
        
        [self.tableView reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //回调失败
        [MBProgressHUD showError:@"网络繁忙，请稍候再试！"];
        MLLog(@"头条请求错误信息：%@", error);
        
    }];
   
    
}



#pragma mark - 实现数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.headlines.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.获取数据模型
    MLHeadLine *headline = self.headlines[indexPath.row];
    
    //2.使用cell模型来创建cell
    
    NSString *ID = [MLHeadLineCell headlineCellWithIdentifier:headline];
    
    MLHeadLineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //3.设置cell
    cell.headline = headline;
    
    //4.返回cell
    return cell;
}

#pragma mark 实现tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLHeadLine *headline = self.headlines[indexPath.row];
    
    if (headline.imgextra.count == 2) {
        return 120; // 120 -> @"ImagesCell"
    }
    if (headline.isBigImage) {
        return 180; // 180 -> @"BigImageCell"
    }
    return 80;  // 80 -> @"NewsCell"

}



#pragma mark - 在控制器跳转之前的准备工作
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 1. 获取tableView选中的行
    NSUInteger row = self.tableView.indexPathForSelectedRow.row;
    
    // 2. 创建目标控制器
    MLNewsDetailViewController *newsDetail = segue.destinationViewController;
    
    // 3. 给目标控制器传递数据
    newsDetail.headline = self.headlines[row];
}







@end
