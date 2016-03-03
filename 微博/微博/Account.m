//
//  Account.m
//  微博
//
//  Created by qingyun on 15/9/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "Account.h"
#import "Common.h"
#import "NSObject+Tool.h"

#define kAccountFileName @"account"


#warning 下行定义接口的作用？
//    添加类的扩展，只对于该.m里使用。
//

@interface Account ()<NSCoding>//遵守NSCoding协议，知识属于归档部分

@property (nonatomic, strong)NSString *accessToken;//访问令牌
@property (nonatomic, strong)NSDate *expires;//有效时间
@property (nonatomic, strong)NSString *uid;//用户的id


@end

@implementation Account

static Account *account;


#warning 单例方法的作用：??????????????????????????
/**
 *   #warning 注释每行的代码???????????????????????????????????????????
     //保存用户成功登陆的信息，创建了单例方法，全局都能访问到。
 */

//解档用户账号的信息，使用户不必每次登录就要输入账号登陆，
+(instancetype)sharedAccount
{
    
    static dispatch_once_t onceToken;   //???
    dispatch_once(&onceToken, ^{
        //解档，先找到文件的路径
        NSString *filePath = [NSObject filePathForDocuments:kAccountFileName];
        //根据文件路径，进行解档，
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        //当解档的前提是必须有文件，若第一次为空的时候，还要进行初始化
        if (!account) {
            account = [[Account alloc]init];
        }
    });
    
    return account;
}

-(void)saveLoginInfo:(NSDictionary *)info
{
    self.accessToken = info[kAccessToken];//代表登陆成功
    
    //访问令牌的有效时间（相当于产品保质期）；当前时间追加上时间间隔，
    self.expires = [[NSDate date] dateByAddingTimeInterval:[info[kExpiresIn] doubleValue]];//NSnumber,NSstring在文档上都有doubleValue方法
    self.uid = info[kUID];
    
    //归档的同时，应该把数据保存到物理文件中,(归档 （NSKeyedArchiver）)
    [NSKeyedArchiver archiveRootObject:account toFile:[NSObject filePathForDocuments:kAccountFileName]];
}

-(BOOL)isLogin{
    //比较时间
    NSComparisonResult result = [self.expires compare:[NSDate date]];
    if (self.accessToken && result == NSOrderedDescending) {//如果登陆且时间比较结果为降序
        return YES;
    }
    return NO;
}

-(void)logout{
    //    这是仅仅删除内存中的登录信息
    self.accessToken = nil;
    self.expires = nil;
    self.uid = nil;
    
    //删除物理文件中的信息
    //删除归档信息
    NSString *filePath = [NSObject filePathForDocuments:kAccountFileName];
    //删除文件，删除文件用NSFileManager
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}
#pragma mark - coding
//初始化方法
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.accessToken = [aDecoder decodeObjectForKey:kAccessToken];
        self.expires = [aDecoder decodeObjectForKey:kExpiresIn];
        self.uid = [aDecoder decodeObjectForKey:kUID];
    }
    return self;
}
//归档方法
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.accessToken forKey:kAccessToken];
    [coder encodeObject:self.expires forKey:kExpiresIn];
    [coder encodeObject:self.uid forKey:kUID];
}

-(NSMutableDictionary *)requestParameters{
    //返回一个包含token的可变字典
    if ([self isLogin]) {
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        [para setObject:self.accessToken forKey:kAccessToken];
        return para;
    }
    return nil;
}


@end
