//
//  QDADViewController.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/28.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDADViewController.h"

@interface QDADViewController ()

@end

@implementation QDADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skipBtn.layer.cornerRadius = 3;
    __weak typeof(self) weakSelf = self;
    [CommonTools addTapGestureWithView:self.imageView block:^(UIView *view) {
        NSLog(@"%@",NSStringFromCGRect(view.frame));
        [weakSelf gotoADDetail];
    }];
    
    [self.skipBtn startWithSecond:3];
    [self.skipBtn didFinished:^NSString *(QDCountDownButton * _Nonnull countDownButton, int second) {
        [weakSelf skipBtnClick:nil];
        return @"";
    }];
}

- (void)gotoADDetail{
    NSDictionary * dic = @{@"url" : @"https://www.baidu.com/"};
    [QDPushRouteHelper handleUserInfo:dic];
}

- (IBAction)skipBtnClick:(id)sender {
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app loadLaunchVC];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}
@end
