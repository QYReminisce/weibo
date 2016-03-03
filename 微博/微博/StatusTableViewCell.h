//
//  StatusTableViewCell.h
//  微博
//
//  Created by qingyun on 15/9/17.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#warning 类的问题?????????????????????
@class Status;

@interface StatusTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *persionIcon;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *source;
@property (strong, nonatomic) IBOutlet UILabel *content;

//Cell视图里面的东西
@property (strong, nonatomic) IBOutlet UIView *imageSuperView;
//将View的高度设置为0.令其变成一条分割“我的转发”与转发内容的一条分割线。把限制高度的约束关联进来
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageSuperViewHeight;

//微博转发内容的属性
@property (strong, nonatomic) IBOutlet UILabel *reStatusContent;
//微博转发的图片
@property (strong, nonatomic) IBOutlet UIView *reStatusImageSuper;

//转发图片高度的约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *reStatusHeight;


+(CGFloat)cellHeightWithStatus:(Status *)status;

-(void)setStatus:(Status *) status;

@end
