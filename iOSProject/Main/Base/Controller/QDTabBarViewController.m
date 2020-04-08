//
//  QDTabBarViewController.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDTabBarViewController.h"

@interface QDTabBarViewController ()

@end

@implementation QDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
}

- (void)setupViewControllers {
    QDHomeViewController *firstViewController = [[QDHomeViewController alloc] init];
    QDBaseNavViewController *firstNavigationController = [[QDBaseNavViewController alloc]initWithRootViewController:firstViewController];
    
    QDMineViewController *fifthViewController = [[QDMineViewController alloc] init];
    QDBaseNavViewController *fifthNavigationController = [[QDBaseNavViewController alloc]initWithRootViewController:fifthViewController];
    
    [self setViewControllers:@[firstNavigationController, fifthNavigationController]];
    
    [self customizeTabBarForController];
}

- (void)customizeTabBarForController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"home", @"mine"];
    NSArray *tabBarItemTitles = @[@"首页", @"我的"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
//        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",[tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.title = [tabBarItemTitles objectAtIndex:index];
        NSDictionary *tabBarTitleUnselectedDic = @{NSForegroundColorAttributeName:QDGetColor(@"707070"),NSFontAttributeName:[UIFont systemFontOfSize:12]};
        NSDictionary *tabBarTitleSelectedDic = @{NSForegroundColorAttributeName:QDGetColor(@"d81e06"),NSFontAttributeName:[UIFont systemFontOfSize:12]};
        //修改tabberItem的title颜色
        item.selectedTitleAttributes = tabBarTitleSelectedDic;
        item.unselectedTitleAttributes = tabBarTitleUnselectedDic;
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

@end
