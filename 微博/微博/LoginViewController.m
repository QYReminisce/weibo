//
//  LoginViewController.m
//  微博
//
//  Created by qingyun on 15/9/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "LoginViewController.h"
#import "common.h"
#import "AFNetworking.h"
#import "Account.h"

@interface LoginViewController ()<UIWebViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //微博api中请求授权的请求URL(由微博API查询获得)
        //也就是加载登陆页面的url,
        //1.下面client_id是appkey（此appkey是申请分配的，可以在微博API中查阅到，此参数显示必填，appkey是开发软件人员在新浪微博上面申请得到的，它是新浪给你另一套系统id标示符；）
        //2.下面redirect_uri也是能在微博API中查阅到，也是必须参数；它是授权回调地址。
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code",kAPP_KEY,kREdirectURI];
    
    //1.将用户引导到认证页面（=将用户引导到登录页面）
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
   // [self.webView.request = request];改行报错，显示readOnly（只读的绝对没有set方法），在dash中查阅用下述方法
    [self.webView loadRequest:request];//讲request指定为webView的request
    [self.webView setDelegate:self];
    
}

- (IBAction)cancel:(id)sender {
    //取消模态视图,(取消登陆账号界面)
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - webView delegate
//webView的代理方法，每次加载的时候都要通过此方法进行询问是否加载请求，因为最终不需要再加载授权回调页，所以返回值为NO；
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    //取出（登陆界面）请求的URl地址
    NSURL *url = request.URL;
    NSString *urlString = [url absoluteString];//转化为url字符串
NSLog(@"LoginViewController.m(登陆界面请求的URL字符串):%@", urlString);
    
    //2.若请求地址是以回调地址开头
        //微博API中回调地址的示例：http://www.example.com/response&code=CODE;
    if ([urlString hasPrefix:kREdirectURI]) {//hasPrefix是以xx开头
       // 取出code授权码
        NSArray *result = [urlString componentsSeparatedByString:@"code="];
        NSString *code = result[1];//等于result的第一个对象（即回调地址--成功登录账号后显示界面的地址）；
        
    //3.换取授权码
        NSString *urlToken = @"https://api.weibo.com/oauth2/access_token";
        NSDictionary *params = @{
                            @"client_id":kAPP_KEY,
                            @"client_secret":@"7fd6214d36cd3b1b93209f85b33fa5c0",
                            @"grant_type":@"authorization_code",
                            @"code":code,
                            @"redirect_uri":kREdirectURI
                            };
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

//#warning 下行代码的意思？
//设置返回序列化器的解析方式，因为原本是无法解析传来的数据（因为是@"text/plain"型），所以追加解析的类型，又因为查阅文档acceptableContentTypes是NSSet类型的，所以等号右边写NSSet。（responseSerializer：返回序列化器）
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
#if 0
//但是上述写法有局限性，因为完全覆盖了原有默认的接受类型，但在该项目中只有此处解析，所以能用，合适的写法应该是在默认解析方法基础上追加上述的方法。

        NSMutableSet *contentTypes = [[NSMutableSet alloc]initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
#endif
        //
        [manager POST:urlToken parameters:params success:^void(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"%@",response);
            
            //4.换取token成功后保存
            [[Account sharedAccount] saveLoginInfo:response];
            
            //删除登录成功后显示“登陆成功的界面”
            [self dismissViewControllerAnimated:YES completion:nil];
            
            //清理cookie
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            
           // 便利所有的cookie
            for (NSHTTPCookie *cookie in storage.cookies) {
                //删除所有的cookie
                [storage deleteCookie:cookie];
            }

            
            
            
        } failure:^void(AFHTTPRequestOperation *operation, NSError *error) {
//    报错代码：1.status code:200代表通信成功；
//             2.fail:unacceptable content-type:text/plain
//
            //AFNetworking强大的功能：它能解析服务器返回的结果，但能解析的类型比较固定，
                        //( 查看解析方式:因为知道返回的数据是json数据，所以查阅AFURLResponseSerialization.m中，点击查阅init方法的代码，就能看到json所支持的解析格式)
            NSLog(@"%@",error);

            
        }];
          return NO;
        
        
    }
    return YES;
}


@end












