//
//  QDBaseNavViewController.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseNavViewController.h"

@interface QDBaseNavViewController ()<UINavigationControllerDelegate>

@end

@implementation QDBaseNavViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.interactivePopGestureRecognizer.enabled = NO;
    __weak QDBaseNavViewController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
    
}

//重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        if ([viewController isKindOfClass:[QDBaseViewController class]]) {
            QDBaseViewController *baseCtr = (QDBaseViewController *)viewController;
            if ([baseCtr respondsToSelector:@selector(leftMenuBarButtonItem)]) {
                baseCtr.navigationItem.leftBarButtonItem = [baseCtr leftMenuBarButtonItem];
            }
        }
    }
    
    //处理左滑手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    if ([viewController isKindOfClass:[QDBaseViewController class]]) {
        QDBaseViewController *baseCtr = (QDBaseViewController *)viewController;
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && baseCtr.popGestureEnable == YES){
            self.interactivePopGestureRecognizer.enabled = YES;
        }else{
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }else{
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.childViewControllers.count > 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    return YES;
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    //只有一个控制器的时候禁止手势，防止卡死现象
    if (self.childViewControllers.count == 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

@end
