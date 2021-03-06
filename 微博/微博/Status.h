//
//  Status.h
//  微博
//
//  Created by qingyun on 15/9/17.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface Status : NSObject


//在微博文档接口中复制的返回字段说明
//created_at	string	微博创建时间
@property (nonatomic, strong)NSDate *createdAt;

//idstr	string	字符串型的微博ID
@property (nonatomic, strong)NSString *idStr;

//text	string	微博信息内容
@property (nonatomic, strong)NSString *text;

//source	string	微博来源
@property (nonatomic, strong)NSString *source;

//favorited	boolean	是否已收藏，true：是，false：否
@property (nonatomic) BOOL favorited;

//geo	object	地理信息字段 详细
@property (nonatomic, strong)id geo;

//user	object	微博作者的用户信息字段 详细
@property (nonatomic, strong)User *user;

//retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回
@property (nonatomic, strong)Status *reStatus;

//reposts_count	int	转发数
@property (nonatomic)NSInteger repostsCount;

//comments_count	int	评论数
@property (nonatomic)NSInteger commentsCount;

//attitudes_count	int	表态数
@property(nonatomic)NSInteger attitudesCount;


//这个是在数据返回中找到的key，表示微博缩略图的KEY
//pic_urls          object 微博的图片
@property(nonatomic, strong)NSArray *picUrls;

//多少时间以前
@property(nonatomic)NSString *timeAgo;

-(instancetype)initStatusWith:(NSDictionary *)statusInfo;

@end
