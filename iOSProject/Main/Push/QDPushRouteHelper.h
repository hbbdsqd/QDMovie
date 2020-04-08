//
//  QDPushRouteHelper.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/27.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDPushRouteHelper : NSObject
/**
 *  跳转类型：HttpLink（内部跳转网页）、AppLink（APP内部跳转）、OtherLink（判断不出来的）
 */
@property (nonatomic, copy) NSString* linkType;
/**
 *  http跳转url
 */
@property (nonatomic, copy) NSString* httpUrl;
/**
 *  跳转模块简称
 */
@property (nonatomic, copy) NSString* moduleName;
/**
 *  AppLink、OperationLink 跳转对应的参数
 */
@property (nonatomic, strong) id parameters;

/**
 跳转的跟控制器
 */
@property (nonatomic,strong) QDBaseViewController *rootViewController;
/**
 *  跳转模块简称
 */
@property (nonatomic,strong) NSDictionary *userinfo;

/**
 处理逻辑
 */
+ (void)handleUserInfo:(NSDictionary *)userinfo;
/**
 处理逻辑,根据跟控制器跳转
 */
+ (void)handleUserInfo:(NSDictionary *)userinfo andRootViewController:(QDBaseViewController *)rootVC;
@end

NS_ASSUME_NONNULL_END
