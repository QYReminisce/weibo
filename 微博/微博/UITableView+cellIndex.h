//
//  UITableView+cellIndex.h
//  微博
//
//  Created by qingyun on 15/9/17.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (cellIndex)

//根据cell的indexPath转化为index；
-(NSInteger)indexForIndexPath:(NSIndexPath *)indexPath;
//根据cell找到所对应的index；
-(NSInteger)indexForCell:(UITableViewCell *)cell;


@end
