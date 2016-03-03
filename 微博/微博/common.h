//
//  common.h
//  微博
//
//  Created by qingyun on 15/9/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#ifndef ___common_h
#define ___common_h



#define kAPP_Version @"app_version" //app版本号

#define kAPP_KEY @"448907665"
#define kREdirectURI @"https://api.weibo.com/oauth2/default.html"


#define kAccessToken @"access_token"//访问令牌

#define kExpiresIn @"expires_in"//令牌的有效时间

#define kUID @"uid"//用户的id

//notifation name
#define kLogOut @"LogOut"
#define kLogIn  @"login"

#define kBaseURL @"https://api.weibo.com/2/statuses"


//解析微博所使用的关键字常量，也就是新浪服务器返回的数据由JSONKit解析后生成的字典关于微博信息的key值
static NSString * const kStatusCreateTime = @"created_at";
static NSString * const kStatusID = @"id";
static NSString * const kStatusIDStr = @"idstr";
static NSString * const kStatusMID = @"mid";
static NSString * const kStatusText = @"text";
static NSString * const kStatusSource = @"source";
static NSString * const kStatusThumbnailPic = @"thumbnail_pic";
static NSString * const kStatusOriginalPic = @"original_pic";
static NSString * const kStatusPicUrls = @"pic_urls";
static NSString * const kStatusRetweetStatus = @"retweeted_status";
static NSString * const kStatusUserInfo = @"user";
static NSString * const kStatusRetweetStatusID = @"retweeted_status_id";
static NSString * const kStatusRepostsCount = @"reposts_count";
static NSString * const kStatusCommentsCount = @"comments_count";
static NSString * const kStatusAttitudesCount = @"attitudes_count";
static NSString * const kstatusFavorited = @"favorited";
static NSString * const kstatusGeo = @"geo";

//解析微博用户数据所使用的关键字常量，也就是新浪服务器返回的数据由JSONKit解后生成的字典关于用户信息的Key值。
static NSString * const kUserInfoScreenName = @"screen_name";
static NSString * const kUserInfoName = @"name";
static NSString * const kUserAvatarLarge = @"avatar_large";
static NSString * const kUserAvatarHd = @"avatar_hd";
static NSString * const kUserID = @"id";
static NSString * const kUserDescription = @"description";
static NSString * const kUserVerifiedReson = @"verified_reason";
static NSString * const kUserFollowersCount = @"followers_count";
static NSString * const kUserStatusCount = @"statuses_count";
static NSString * const kUserFriendCount = @"friends_count";
static NSString * const kUserStatusInfo = @"status";
static NSString * const kUserStatuses = @"statuses";
static NSString * const kUserProfileImageURL = @"profile_image_url";

//view

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width


#endif
