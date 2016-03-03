//
//  UITableView+cellIndex.m
//  微博
//
//  Created by qingyun on 15/9/17.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "UITableView+cellIndex.h"

@implementation UITableView (cellIndex)

-(NSInteger)indexForCell:(UITableViewCell *)cell{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    return [self indexForIndexPath:indexPath];
}

-(NSInteger)indexForIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = 0;
    
    //将section的row的和加起来（cell之前的cection）
    for (int i = 0; i < indexPath.section; i++) {
        index += [self numberOfRowsInSection:i];
    }
    
    //index加上当前所在的row
    index += indexPath.row;
    
    return index;
}



@end
