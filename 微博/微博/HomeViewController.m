//
//  HomeViewController.m
//  微博
//
//  Created by qingyun on 15/9/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "HomeViewController.h"
#import "Common.h"
#import "AFNetworking.h"
#import "Account.h"
#import "StatusTableViewCell.h"
#import "Status.h"
#import "DataBaseEngine.h"


//微博请求数据的VC操作
@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *statues;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    //添加登陆成功的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:kLogIn object:nil];
    
    //判断从本地加载还是从网络上加载
    if ([[Account sharedAccount] isLogin]) {
        //从数据库中查询出内容
        self.statues = [NSMutableArray arrayWithArray:[DataBaseEngine statusesFromDB]];
        //网络中请求数据
        [self loadData];
    }
}

-(void)login{
    //请求数据
    [self loadData];
}

-(void)loadData{
    //向微博平台请求数据
    NSString *urlString = [kBaseURL stringByAppendingPathComponent:@"home_timeline.json"];
    
    //请求的参数
    NSMutableDictionary *parameters = [[Account sharedAccount] requestParameters];
    
    //返回3条
    [parameters setObject:@30 forKey:@"count"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameters success:^void(AFHTTPRequestOperation * operation, id reponse) {
        NSLog(@"%@", reponse);
        
        //请求到的数据数组
        NSArray *statusInfo = [NSMutableArray arrayWithArray:reponse[@"statuses"]];
        
        self.statues = [NSMutableArray array];
        //遍历数据
        for (NSDictionary *info in statusInfo) {
            Status *status = [[Status alloc] initStatusWith:info];
            [self.statues addObject:status];
        }
        
        //重要，更新UI
        [self.tableView reloadData];
        
        //加载数据（前提：判断是从本地已有数据加载或者从网络加载）
        [DataBaseEngine saveStatuses2Database:statusInfo];
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];
}

#pragma mark - tableView delegate datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statues.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
    
    [cell setStatus:self.statues[indexPath.row]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //计算cell需要的高度
    return  [StatusTableViewCell cellHeightWithStatus:self.statues[indexPath.row]];
}

@end
