//
//  NSObject+Tool.m
//  微博
//
//  Created by qingyun on 15/9/15.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "NSObject+Tool.h"



@implementation NSObject (Tool)

+(NSString *)filePathForDocuments:(NSString *)fileName
{
//!!!!!重温熟悉归档的代码=============================================
    
    //归档的文件路径
    NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [documents stringByAppendingPathComponent:fileName];
    
    return filePath;
}
@end
