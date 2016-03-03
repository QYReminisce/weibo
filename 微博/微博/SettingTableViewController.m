//
//  SettingTableViewController.m
//  微博
//
//  Created by qingyun on 15/9/17.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SettingTableViewController.h"
#import "Account.h"
#import "common.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"
#import "UITableView+cellIndex.h"


@interface SettingTableViewController ()

@property (nonatomic, strong)NSArray *cellTitle;


@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //cell的标题
    
    if ([[Account sharedAccount] isLogin]) {
        self.cellTitle = @[@[@"账号管理"], @[@"通知设置", @"通用设置", @"隐私与安全"], @[@"清理缓存", @"意见反馈", @"关于微博"], @[@"退出当前账号"]];
    }else{
        self.cellTitle = @[@[@"通用设置"], @[@"关于微博"]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellTitle[section] count];
}
//之前一般的版本
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];
//    
//    //注意是二维数组，注意取的方法
//    cell.textLabel.text = self.cellTitle[indexPath.section][indexPath.row];
//    cell.detailTextLabel.text = nil;
//    
//    //
//    if (indexPath.section == 3) {
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        cell.textLabel.textColor = [UIColor orangeColor];
//    }
//    else{//注意必须写else，因为假如存在的cell超过一页视图显示的cell数目，由于复用机制，所以之后肯定会有复用的另一个cell显示黄色。这时候便不符合起初的要求，
//        cell.textLabel.textAlignment = NSTextAlignmentLeft;
//        cell.textLabel.textColor = [UIColor blackColor];
//    }
//    
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell;
    //不同的cell设置为不同的样式
    if (indexPath.section == 3) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor orangeColor];
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        
        //显示本地的缓存大小
        if (indexPath.section == 2 && indexPath.row == 0) {
            NSInteger size = [[SDImageCache sharedImageCache] getSize];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f MB", (float)size/1024/1024];
        }
        
    }
    
    //绑定cell上的内容
    cell.textLabel.text = self.cellTitle[indexPath.section][indexPath.row];
    
    return cell;
}

//一般的版本
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 3) {
//        //选择退出登录
//        
//        //构造控制器
//        UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//        
//        //构造按钮
//        UIAlertAction *logout = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            //退出登录
//            //通知主控制器
//            [[NSNotificationCenter defaultCenter] postNotificationName:kLogOut object:nil];
//            //返回上一个控制器
//            [self.navigationController popViewControllerAnimated:YES];
//            
//            
//        }];
//        
//        UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        
//        //将按钮添加到控制器
//        [controller addAction:logout];
//        [controller addAction:alertCancel];
//        [self presentViewController:controller animated:YES completion:nil];
//        
//        
//    }
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch ([tableView indexForIndexPath:indexPath]) {
        case 7:
        {
            //构造控制器
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            //构造按钮
            UIAlertAction *logout = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //退出登录
                //通知主控制器
                [[NSNotificationCenter defaultCenter] postNotificationName:kLogOut object:nil];
                //返回上一个控制器
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }];
            
            UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            //将按钮添加到控制器
            [controller addAction:logout];
            [controller addAction:alertCancel];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        case 4:{
            //构造控制器
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            //构造按钮
            UIAlertAction *logout = [UIAlertAction actionWithTitle:@"清除缓存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //清除所有的sd的image缓存
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    //清除缓存成功
                    [SVProgressHUD showSuccessWithStatus:@"清除成功！"];
                    [self.tableView reloadData];
                    
                }];
                
                
            }];
            
            UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            //将按钮添加到控制器
            [controller addAction:logout];
            [controller addAction:alertCancel];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
    
}



@end
