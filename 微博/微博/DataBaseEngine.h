//
//  DataBaseEngine.h
//  微博
//
//  Created by qingyun on 15/9/19.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseEngine : NSObject

//该文件的作用是：已经加载过的微博文件当第二次查阅时从本地加载，不需再耗费流量到网络上加载

/**
 *  储存微博数据到数据库
 */
+(void)saveStatuses2Database:(NSArray *)statuses;

/**
 *  从数据库中查询数据
 */
+(NSArray *)statusesFromDB;


@end
