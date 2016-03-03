//
//  MainViewController.m
//  微博
//
//  Created by qingyun on 15/9/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "MainViewController.h"
#import "Account.h"
#import "common.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置tabbar的tintColor
    self.tabBar.tintColor = [UIColor orangeColor];
    
    //设置默认选择的控制器
    
    if(![[Account sharedAccount] isLogin]){
        
        
        //为了触发首页控制器的didload方法
        UINavigationController *nav = self.viewControllers[0];
        [nav.viewControllers[0] view];
        
        self.selectedIndex = 2;
    }
    
    
    //监听退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:kLogOut object:nil];
    //监听登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:kLogIn object:nil];
}

-(void)logout{
    //收到退出登陆的通知
    //1.登录界面
    //2.切换控制器
    //3.清空保存登录信息
    
    //注意login（SB里面对应的VC）本身有一个SB属性，注意此处出队的控制器，loginNav相当于login的根视图
    UIViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNav"];
    
    //呈现控制器
    [self presentViewController:login animated:YES completion:nil];
    
    //切换控制器
    self.selectedIndex = 2;
    
    //用户退出
    [[Account sharedAccount] logout];
    
}

-(void)login{
    //选择到首页控制器
    self.selectedIndex = 0;
}


@end
