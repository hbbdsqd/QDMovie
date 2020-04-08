//
//  AppDelegate.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "AppDelegate.h"
#import "QDGuideViewController.h"
#import "QDADViewController.h"
#import <UMCommon/UMCommon.h>
//#import <ShareSDK/ShareSDK.h>
//#import "WXApi.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


/**
 APP启动
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self loadLaunchVC];
    [self loadDefault];
    return YES;
}

- (void)loadDefault{
     [UMConfigure initWithAppkey:@"5e4370080cafb223db000062" channel:@"App Store"];
    [self initMob];
}
#pragma mark mob分享配置
- (void)initMob{
//    //    [WXApi registerApp:WXAppId];
//    [WXApi registerApp:WXShareAPPID enableMTA:YES];
//    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
//        //微信
//        [platformsRegister setupWeChatWithAppId:WXShareAPPID appSecret:WXShareAPPSecret];
//    }];
}
/**
 展示广告图
 */
- (void)loadADVC{
    QDADViewController * adVC = [[QDADViewController alloc]init];
    self.window.rootViewController = adVC;
}

/**
 判断加载控制器
 */
- (void)loadLaunchVC{
//    修改引导图版本号即可展示：Macros-》QDGuideVersion
//    if ([CommonTools changeSHowGuideVC]) {
//        QDGuideViewController * guideVC = [[QDGuideViewController alloc]init];
//        self.window.rootViewController = guideVC;
//    }else{
//        self.tabbarVC = [[QDTabBarViewController alloc]init];
//        [self.tabbarVC setupViewControllers];
//        self.window.rootViewController = self.tabbarVC;
//    }
    self.tabbarVC = [[QDTabBarViewController alloc]init];
    [self.tabbarVC setupViewControllers];
    self.window.rootViewController = self.tabbarVC;
}
 

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"\n ===> 程序暂行 !");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"\n ===> 程序进入后台 !");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"\n ===> 程序进入前台 !");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"\n ===> 程序重新激活 !");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"\n ===> 程序意外暂行 !");
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"iOSProject"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
