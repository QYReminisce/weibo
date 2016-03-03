//
//  NSDateFormatter+Status.m
//  微博
//
//  Created by qingyun on 15/9/17.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "NSDateFormatter+Status.h"

@implementation NSDateFormatter (Status)

-(NSDate *)statusDateFromString:(NSString *)dateString{
    
    //指定时间格式
    self.dateFormat = @"EEE MMM dd HH:mm:ss zzz yyyy";
    return [self dateFromString:dateString];
}


@end
