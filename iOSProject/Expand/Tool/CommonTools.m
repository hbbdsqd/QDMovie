//
//  Commtools.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "CommonTools.h"

@interface CommonTools ()<UIAlertViewDelegate>

@end

@implementation CommonTools
+ (CommonTools*)insatance
{
    static CommonTools* tools = nil;
    static dispatch_once_t toolsDispath;
    dispatch_once(&toolsDispath, ^{
        tools = [[CommonTools alloc] init];
    });
    return tools;
}

+ (BOOL)isBlankString:(NSString *)string{
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+ (QDBaseViewController *)getClassVCWithName:(NSString *)className{
    
    Class cls = NSClassFromString(className);
    BOOL isSubClass = [cls isSubclassOfClass:[QDBaseViewController class]];
    if (isSubClass) {
        return (QDBaseViewController *)[[cls alloc]init];
    }else{
        return [[QDBaseViewController alloc]init];
    }
}

+ (BOOL)changeSHowGuideVC{
    BOOL show = NO;
    if ([CommonTools isBlankString:[QDUserDefault getGuideVersion]] || ![[QDUserDefault getGuideVersion] isEqualToString:QDGuideVersion]) {
        show = YES;
    }
    return show;
}

+ (void)gotoHomeVC{
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.tabbarVC = [[QDTabBarViewController alloc]init];
    [app.tabbarVC setupViewControllers];
    app.tabbarVC.selectedIndex = 0;
    app.window.rootViewController = app.tabbarVC;
    [app.window makeKeyAndVisible];
}

+ (void)addTapGestureWithView:(UIView *)view block:(tapGestureBlock)block{
    [CommonTools insatance].tapBlock = block;
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [view addGestureRecognizer:tap];
}

+ (void)tapClick:(UITapGestureRecognizer *)gec{
    if ([CommonTools insatance].tapBlock) {
        [CommonTools insatance].tapBlock(gec.view);
    }
    
}
+ (NSString *)getStringWithDic:(NSDictionary *)dic key:(NSString *)key{
    if ([[dic valueForKeyPath:key] isKindOfClass:[NSString class]]) {
        if ([CommonTools isBlankString:[dic valueForKeyPath:key]]) {
            return @"";
        } else {
            return [NSString stringWithFormat:@"%@",[dic valueForKeyPath:key]];
        }
    }else{
        if ([dic valueForKeyPath:key] == nil || [dic valueForKeyPath:key] == NULL) {
            return @"";
        }
        if ([[dic valueForKeyPath:key] isKindOfClass:[NSNull class]]) {
            return @"";
        }
        return [NSString stringWithFormat:@"%@",[dic valueForKeyPath:key]];
    }
}

+ (NSString *)getURLStr:(NSString *)str{
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
}
@end
