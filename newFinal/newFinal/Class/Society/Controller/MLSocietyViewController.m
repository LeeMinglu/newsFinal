//
//  MLSocietyViewController.m
//  newFinal
//
//  Created by 李明禄 on 15/12/16.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLSocietyViewController.h"
#import "MLHTTPManager.h"
#import "MLSocietyCell.h"
#import "MBProgressHUD+MLExtension.h"
#import "MLSociety.h"
#import "UIImageView+WebCache.h"



@interface MLSocietyViewController ()
@property (nonatomic, strong) NSArray *societies;

@end

@implementation MLSocietyViewController

static NSString *const  ID = @"Society_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [self setupRequestData];
    
    }


- (void)setupRequestData {
    //1.根据域名拼接URL请求路径
    NSString *domainURL = [kNetEaseDomain stringByAppendingString:self.urlString];
    
    domainURL = [NSString stringWithFormat:@"%@/0-140.html", domainURL];
    
    
    //2.向服务器发送请求
    [[MLHTTPManager manager] GET:domainURL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        //成功回调，字典转模型
        NSArray *dictArray = responseObject[self.urlString];
        
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            MLSociety *society = [MLSociety societyWithDict:dict];
            [arrayModel addObject:society];
        }
        
        self.societies = arrayModel;
        
        //3.刷新数据，否则不会显示数据
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后再试"];
        MLLog(@"society失败信息:%@", error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.societies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLSociety *society = self.societies[indexPath.row];
    
    NSString *ID = [MLSocietyCell societyCellWithIdentifier:society];
    
    MLSocietyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.society = society;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLSociety *society = self.societies[indexPath.row];
    if (society.hasHead) {
        return 180;
    }else {
        return 80;
    }
}
@end
