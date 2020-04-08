//
//  QDBaseViewController.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseViewController.h"

@interface QDBaseViewController ()

@end

@implementation QDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = QDGetColor(@"ffffff");
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self setNeedsStatusBarAppearanceUpdate];
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.navigationBar.translucent = NO;
   
    //  底部横线就没有了

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    self.page_num = 1;
    self.page_size = 20;
}



- (void)addRefreshWithTableView:(UITableView *)tableView{
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
//    [tableView.mj_header beginRefreshing];
}

- (void)headerRefresh{
    
}

- (void)footerRefresh{
    
}

- (void)setPopGestureEnable:(BOOL)popGestureEnable{
    if (!popGestureEnable) {
        id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
        [self.view addGestureRecognizer:pan];
    }
}

-(void)showNoDataViewToView:(UIView *)superview withString:(NSString*)string {
    UIView *viewold=[superview viewWithTag:1234987];
    if (viewold) {
        [viewold removeFromSuperview];
    }
    UIView *createview=[[UIView alloc]initWithFrame:CGRectMake(0,0,CGRectGetWidth(superview.frame), CGRectGetHeight(superview.frame))];
    createview.autoresizingMask = UIViewAutoresizingNone;
    createview.tag=1234987;
    createview.backgroundColor = [UIColor clearColor];
    createview.userInteractionEnabled = YES;
    [superview addSubview:createview];
    [superview bringSubviewToFront:createview];
    
    UIImage* uiimg=[UIImage imageNamed:@"not found"];
    UIImageView* imgV=[[UIImageView alloc]initWithImage:uiimg];
    imgV.frame=CGRectMake((CGRectGetWidth(superview.frame)-uiimg.size.width)/2.0, 0, uiimg.size.width, uiimg.size.height);
    imgV.autoresizingMask = UIViewAutoresizingNone;
    
    imgV.userInteractionEnabled = YES;
    
    [createview addSubview:imgV];
    imgV.centerY = createview.height*3/8.0;
    
    
    CGFloat height = [string heightForFont:[UIFont systemFontOfSize:16] width:(CGRectGetWidth(superview.frame) - 40)];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(imgV.frame)+10,CGRectGetWidth(superview.frame) - 40, height + 20)];
    label.autoresizingMask = UIViewAutoresizingNone;
    label.text= string;
    label.textColor = [UIColor colorWithHexString:@"9B9B9B"];
    label.font=[UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [createview addSubview:label];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRefresh)];
    [createview addGestureRecognizer:tap];
    
}

- (void)tapRefresh{
    
}

-(void)hideNoDataViewFromView:(UIView *)superview {
    UIView *view=[superview viewWithTag:1234987];
    if (view) {
        [view removeFromSuperview];
    }
}

- (void)creatLeftBtnOfReturn{

    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:QDGetImage(@"back") style:UIBarButtonItemStylePlain target:self action:@selector(returnClick)];
}
- (void)creatLeftBtnOfLoginReturn{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[QDGetImage(@"login_back") imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:UIBarButtonItemStylePlain target:self action:@selector(returnClick)];
}
- (void)returnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatLeftBtnOfCustomWithTitle:(NSString *)title{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClcik)];
}
- (void)creatLeftBtnOfCustomWithTitle:(NSString *)title textColor:(UIColor *)textColor{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(leftBtnClcik) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
- (void)leftBtnClcik{
    
}

- (void)creatRightBtnOfCustomWithTitle:(NSString *)title{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:QDColorMain forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(rightBtnClcik) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)creatRightBtnOfCustomWithTitle:(NSString *)title textColor:(UIColor *)textColor{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(rightBtnClcik) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)rightBtnClcik{
    
}


- (void)creatLeftBtnOfCustomWithImage:(NSString *)imageName{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:imageName renderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClcik)];
}

- (void)creatRightBtnOfCustomWithImage:(NSString *)imageName{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:imageName renderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClcik)];
}
- (void)creatSearchBtn{
    
    UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 4, QDScreen_Width - 67 , 36)];
    textField.placeholder = @"搜索电影、电视剧、综艺、动漫";
    textField.backgroundColor = QDGetColor(@"F5F5F5");
    textField.font = QDGetFont(14);
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, textField.height, textField.height)];
    imageView.image = [UIImage imageNamed:@"Nav_left_icon_search_balck"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    textField.leftView = imageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.userInteractionEnabled = YES;
    [textField cornerAllCornersWithCornerRadius:6];
    __weak typeof(self) weakSelf = self;
    [textField jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf leftBtnClcik];
    }];
    
    self.navigationItem.titleView = textField;
}


//设置导航栏左边按钮
- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back" renderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backPopViewcontroller:)];
}

- (void)backPopViewcontroller:(id) sender
{
    NSLog(@"super backPopViewcontroller");
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableDictionary *)dataDict{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prefersStatusBarHidden];
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}
@end
