//
//  Account.h
//  微博
//
//  Created by qingyun on 15/9/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

//该Acount是用户登录信息储存的下得数据

//单例方法
+(instancetype)sharedAccount;

//保存登录信息
-(void)saveLoginInfo:(NSDictionary *)info;

//判断是否登录
-(BOOL)isLogin;

//退出登录
-(void)logout;

//返回包含token的可变字典，用作请求的参数；
-(NSMutableDictionary *)requestParameters;


@end
