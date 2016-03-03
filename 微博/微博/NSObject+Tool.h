//
//  NSObject+Tool.h
//  微博
//
//  Created by qingyun on 15/9/15.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>


//创建该类的目的：获取Documents文件夹下文件的路径
@interface NSObject (Tool)

+(NSString *)filePathForDocuments:(NSString *)fileName;


@end
