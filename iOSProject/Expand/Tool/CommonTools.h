//
//  Commtools.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^tapGestureBlock)(UIView * _Nullable view);

NS_ASSUME_NONNULL_BEGIN

@interface CommonTools : NSObject
@property (nonatomic, copy) tapGestureBlock tapBlock;

/**
 判断字符串是否为空值
 */
+ (BOOL)isBlankString:(NSString *)string;
/**
 动态获取控制器
 */
+ (QDBaseViewController *)getClassVCWithName:(NSString *)className;
/**
 判断是否展示引导图  yes 展示   no 不展示
 */
+ (BOOL)changeSHowGuideVC;

/**
 跳转到主页
 */
+ (void)gotoHomeVC;

/**
 给view添加点击事件

 @param block 返回事件回调
 */
+ (void)addTapGestureWithView:(UIView *)view block:(tapGestureBlock)block;

/**
 字典根据key获取ValueString,避免取值为空的情况
 如果取值为空，直接赋值@“”
 */
+ (NSString *)getStringWithDic:(NSDictionary *)dic
                           key:(NSString *)key;

/// 获取url转义
+ (NSString *)getURLStr:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
