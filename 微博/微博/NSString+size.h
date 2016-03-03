//
//  NSString+size.h
//  微博
//
//  Created by qingyun on 15/9/18.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning xiayihang??????????????????
#import <UIKit/UIKit.h>

@interface NSString (size)

//根据文字显示的区域以及大小，计算最终显示所需要的空间
-(CGSize)sizeWithFont:(UIFont *)font Size:(CGSize)size;


@end
