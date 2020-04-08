//
//  QDPushRouteHelper.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/27.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDPushRouteHelper.h"

@implementation QDPushRouteHelper
+ (instancetype)manager
{
    static QDPushRouteHelper* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
+ (void)handleUserInfo:(NSDictionary *)userinfo{
    [QDPushRouteHelper manager].userinfo = userinfo;
    [QDPushRouteHelper manager].rootViewController = nil;
    [[QDPushRouteHelper manager] changeLinkType:[userinfo getValueForKey:@"url"]];
    [[QDPushRouteHelper manager] gotoVC];
}

+ (void)handleUserInfo:(NSDictionary *)userinfo andRootViewController:(QDBaseViewController *)rootVC{
    [QDPushRouteHelper manager].userinfo = userinfo;
    [QDPushRouteHelper manager].rootViewController = rootVC;
    [[QDPushRouteHelper manager] changeLinkType:[userinfo getValueForKey:@"url"]];
    [[QDPushRouteHelper manager] gotoVC];
}

- (void)gotoVC{
    if ([self.linkType isEqualToString:@"AppLink"]) {
        QDBaseViewController * pushVC = [self applinkVC];
        if (!pushVC || pushVC == nil) {
            NSString* errorStr = [NSString stringWithFormat:@"无效的跳转链接 moduleName = %@", self.moduleName];
            NSLog(@"%@",errorStr);
        }else{
            [self loadRootViewController];
            [self pushToAppVC:pushVC parameters:self.parameters rootController:self.rootViewController];
        }
    }else if ([self.linkType isEqualToString:@"HttpLink"]){
        [self loadRootViewController];
//        QDBaseWebViewViewController * webVC = [[QDBaseWebViewViewController alloc]init];
//        webVC.urlStr = self.httpUrl;
//        [self.rootViewController.navigationController pushViewController:webVC animated:NO];
    }else if ([self.linkType isEqualToString:@"OtherLink"]){
        
    }else{
        
    }
}

- (void)pushToAppVC:(QDBaseViewController*)pushVC
         parameters:(NSDictionary*)parameters
     rootController:(UIViewController*)rootController
{
    if (pushVC) {
        dispatch_async(dispatch_get_main_queue(), ^{
            unsigned int outCount = 0;
            objc_property_t * properties = class_copyPropertyList(pushVC.class , &outCount);
            for (int i = 0; i < outCount; i++) {
                objc_property_t property = properties[i];
                NSString *key = [NSString stringWithUTF8String:property_getName(property)];
                NSString *param = parameters[key];
                if (param != nil) {
                    [pushVC setValue:param forKey:key];
                }
            }
            [rootController.navigationController pushViewController:pushVC animated:NO];
        });
    }
}

- (void)loadRootViewController{
    if (self.rootViewController) {
        return;
    }
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.tabbarVC = [[QDTabBarViewController alloc]init];
    app.window.rootViewController = app.tabbarVC;
    [app.tabbarVC setupViewControllers];
//    if ([self.moduleName isEqualToString:NSStringFromClass([MuLiveController class])]) {
//        tabbarVC.selectedIndex = 0;
//    }else if ([self.moduleName isEqualToString:NSStringFromClass([NGCooperationMainViewController class])]){
//        tabbarVC.selectedIndex = 1;
//    }else if ([self.moduleName isEqualToString:NSStringFromClass([NGConsultViewController class])]){
//        tabbarVC.selectedIndex = 2;
//    }else if ([self.moduleName isEqualToString:NSStringFromClass([NGMineMainViewController class])]){
//        tabbarVC.selectedIndex = 3;
//    }else{
//        tabbarVC.selectedIndex = 0;
//    }
    
    app.tabbarVC.selectedIndex = 0;
    QDBaseNavViewController * navc = (QDBaseNavViewController *)app.tabbarVC.selectedViewController;
    self.rootViewController = (QDBaseViewController *)navc.topViewController;
}

- (QDBaseViewController*)applinkVC
{
    id resultVC = nil;
    NSString* className = self.moduleName;
    Class pushVCClass = NSClassFromString(className);
    BOOL isSubClass = [pushVCClass isSubclassOfClass:[QDBaseViewController class]];
    if (isSubClass) {
        resultVC = (QDBaseViewController*)[[pushVCClass alloc] init];
    }
    return resultVC;
}

- (void)changeLinkType:(NSString *)url{
    self.linkType = @"OtherLink";
    self.parameters = [NSDictionary dictionary];
    self.moduleName = @"";
    
    if ([CommonTools isBlankString:url]) {
        NSString* errorStr = [NSString stringWithFormat:@"无效的跳转链接 url = %@", url];
        NSLog(@"%@",errorStr);
        self.linkType = @"OtherLink";
    }else{
        NSLog(@"跳转链接 %@", url);
        NSRange appRange = [url rangeOfString:@"qdshow://"];
        BOOL HttpPrefix = [url hasPrefix:@"http://"];
        BOOL HttpsPrefix = [url hasPrefix:@"https://"];
        BOOL shopshopsPrefix = [url hasPrefix:@"qdshow://"];
        
        if (HttpPrefix || HttpsPrefix) {
            self.linkType = @"HttpLink";
            self.httpUrl = url;
        } else if (shopshopsPrefix) {
            NSRange parametersRange = [url rangeOfString:@"?"];
            self.linkType = @"AppLink";
            //有参数
            if (parametersRange.location != NSNotFound) {
                //模块名称
                NSString* theModuleName = [url substringWithRange:NSMakeRange(appRange.location + appRange.length, (parametersRange.location - (appRange.location + appRange.length)))];
                if ([CommonTools isBlankString:theModuleName]) {
                    self.linkType = @"OtherLink";
                    NSString* errorStr = [NSString stringWithFormat:@"无效的跳转链接 url = %@", url];
                    NSLog(@"%@",errorStr);
                }else{
                    //指定操作
                    NSDictionary* parameters = [self pushParametersWithFormEncodedData:[url substringFromIndex:parametersRange.location + 1]];
                    self.parameters = parameters;
                    self.moduleName = theModuleName;
                }
                
            }
            //无参数
            else {
                //模块名称
                NSString* theModuleName = [url substringFromIndex:appRange.location + appRange.length];
                if ([CommonTools isBlankString:theModuleName]) {
                    self.linkType = @"OtherLink";
                    NSString* errorStr = [NSString stringWithFormat:@"无效的跳转链接 url = %@", url];
                    NSLog(@"%@",errorStr);
                }else{
                    self.moduleName = theModuleName;
                }
            }
        } else {
            self.linkType = @"OtherLink";
            NSString* errorStr = [NSString stringWithFormat:@"无效的跳转链接 url = %@", url];
            NSLog(@"%@",errorStr);
        }
    }
}

- (NSDictionary*)pushParametersWithFormEncodedData:(NSString*)formData
{
    NSArray* params = [formData componentsSeparatedByString:@"&"];
    
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    for (NSString* param in params) {
        NSArray* pv = [param componentsSeparatedByString:@"="];
        NSString* v = @"";
        if ([pv count] == 2) {
            v = [self decodeURIComponent:[pv objectAtIndex:1]];
            [result setObject:v forKey:[pv objectAtIndex:0]];
        }
    }
    return result;
}

- (NSString *)decodeURIComponent:(NSString *)str
{
    NSString *result =
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                              kCFAllocatorDefault,
                                                                              (CFStringRef)str,
                                                                              CFSTR(""),
                                                                              kCFStringEncodingUTF8));
    return result;
}
@end
