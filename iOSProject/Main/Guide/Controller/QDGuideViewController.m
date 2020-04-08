//
//  QDGuideViewController.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/28.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDGuideViewController.h"

@interface QDGuideViewController ()<UIScrollViewDelegate>

@end

@implementation QDGuideViewController{
    NSInteger _num;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skipBtn.layer.cornerRadius = 3;
    self.goHomeBtn.layer.borderColor = QDColorWhite.CGColor;
    self.goHomeBtn.layer.borderWidth = 1;
    self.goHomeBtn.layer.cornerRadius = 3;
    [self loadScrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)loadScrollView{
    _num = 4;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * _num, self.scrollView.height);
    self.pageControl.numberOfPages = _num;
    for (NSInteger index = 0; index < _num; index++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(QDScreen_Width * index, 0, QDScreen_Width, QDScreen_Height);
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%ld",(long)index + 1]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.scrollView addSubview:imageView];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = index;
    if (index == (_num - 1)) {
        self.skipBtn.hidden = YES;
        self.goHomeBtn.hidden = NO;
    }else{
        self.skipBtn.hidden = NO;
        self.goHomeBtn.hidden = YES;
    }
}

- (IBAction)skipBtnClick:(id)sender {
    [QDUserDefault setGuideVersion];
    [CommonTools gotoHomeVC];
}
- (IBAction)goHomeBtnClick:(id)sender {
    [QDUserDefault setGuideVersion];
    [CommonTools gotoHomeVC];
}

@end
