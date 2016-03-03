//
//  GuideVC.m
//  微博
//
//  Created by qingyun on 15/9/11.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "GuideVC.h"
#import "AppDelegate.h"

@interface GuideVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.scrollView.contentSize = CGSizeMake(1500, 667);
    self.pageControl.enabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
}

//没有下行该代码，图片的大小不会和所有尺寸的手机相匹配
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //约束在viewDidAppear之后起作用，调整contentView的大小，根据其大小调整scrollViewContentSize
    self.scrollView.contentSize = self.contentView.frame.size;
    
}

- (IBAction)guideEnd:(id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate guideEnd];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //计算出第几页
    self.pageControl.currentPage = self.scrollView.contentOffset.x/self.scrollView.frame.size.width;
}

@end
