//
//  FindViewController.m
//  微博
//
//  Created by qingyun on 15/9/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "FindViewController.h"
#import "Account.h"

@interface FindViewController ()
//注意此处的强引用
@property (strong, nonatomic) IBOutlet UIBarButtonItem *LoginButton;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //根据登录状态确定登录按钮是否显示,重点注意，此处的LoginButton在SB拖过来调整到强引用，若使用平常的弱引用，当它设定为空的时候就会自动释放，而此处要求根据是是否登陆来显示LoginButton的状态，所以用强引用，不会被释放。
    if ([[Account sharedAccount] isLogin]) {
        self.navigationItem.rightBarButtonItem = nil;
    }else{
        self.navigationItem.rightBarButtonItem = self.LoginButton;
    }
//总结：如果想把一个对象消失，但它却又确实存在，可以将它变成强引用，再让它等于空。enable = NO的方法只能让它显示不可用状态，它UI效果如同占位符效果，能看得到但仅仅不可用。
}



@end

//总结：如果想把一个对象消失，但它却又确实存在，可以将它变成强引用，再让它等于空。enable = NO的方法只能让它显示不可用状态，它UI效果如同占位符效果，能看得到但仅仅不可用。