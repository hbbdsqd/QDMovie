//
//  Macros.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#pragma mark - 引导图版本控制
#define QDGuideVersion @"1.0.1"

#pragma mark - 字体
#define QDGetFont(fontSize) [UIFont systemFontOfSize:fontSize]
#define QDGetPFSemiboldFont(fontSize) [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize]
#define QDGetPFRegularFont(fontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize]
#define QDGetPFMediumFont(fontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize]

#pragma mark - 版本


#pragma mark - 色值
#define QDColorWhite [UIColor whiteColor]
#define QDGetColor(colorStr) [UIColor colorWithHexString:colorStr]
#define QDColorBtnDisSelectedColor [UIColor colorWithHexString:@"D2D5DB"]
#define QDColorMain QDGetColor(@"57818B")
#define QDColoeCategorySelected QDGetColor(@"333333")
#define QDColorCateBackGroundColor QDGetColor(@"ffffff")
#define QDColoeCategoryNotSelected QDGetColor(@"666666")
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#pragma mark - 快捷方式
#define QDGetImage(imageName) [UIImage imageNamed:imageName renderingMode:UIImageRenderingModeAlwaysOriginal]


#pragma mark - MBProgressHUD
#define QDShowMessage(message) [MBProgressHUD showMessage:message];
#define QDShowError(error) [MBProgressHUD showError:error];
#define QDShowSuccess(success) [MBProgressHUD showSuccess:success];
#define QDShowWarn(warn) [MBProgressHUD showWarning:warn];
#define QDShowLoading [MBProgressHUD showActivityMessage:@"加载中..."];
#define QDHideHud [MBProgressHUD hideHUD];


#pragma mark - DEBUGNSLog
#ifdef DEBUG
// 定义是输出Log
#define NSLog(format, ...) NSLog(@"Line[%d] %s " format, __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
// 定义是输出Log
#define NSLog(format, ...)
#endif



#pragma mark - 屏幕
#define QDisRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define QDQD5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define QDQD6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define QDQD6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define QDisPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define QDisPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define QDIOS11   @available(iOS 11.0, *)
#define QDQDX ([UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f)

#define QDScreen_Width  [UIScreen mainScreen].bounds.size.width
#define QDScreen_Height   [UIScreen mainScreen].bounds.size.height
#define QDStatusBarHeight (QDScreen_Height >= 812.0 ? 44 : 20)
#define QDSafeAreaBottomHeight (QDScreen_Height >= 812.0 ? 34 : 0)//底部
#define QDNavigationBarHeight 44
#define QDNavigationBarIcon 20
#define QDTabBarHeight 49
#define QDTabBarIcon 30

#pragma mark - 弱引用、强引用
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define QDWeak(var, weakVar) __weak __typeof(&*var) weakVar = var
#define QDStrong(weakVar, _var) QDStrong_DoNotCheckNil(weakVar, _var); if (!_var) return;
/** defines a weak `self` named `weakSelf` */
#define QDWeakSelf      QDWeak(self, weakSelf);
/** defines a strong `self` named `strongSelf` from `weakSelf` */
#define QDStrongSelf    QDStrong(weakSelf, strongSelf);

#pragma mark - 判断字符串、数组、字典、对象为空
//字符串是否为空
#define QDStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define QDArrayIsEmpty(array) ((array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0) ? YES : NO)
//字典是否为空
#define QDDictIsEmpty(dic) ((dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0) ? YES : NO)
//是否是空对象
#define QDObjectIsEmpty(_object) ((_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0)) ? YES : NO)

#pragma mark - 路径
//获取沙盒Document路径
#define PCBDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define PCBTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define PCBCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//Library/Caches 文件路径
#define PCBFilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])


#pragma mark - 网络相关的宏
#define TIMEOUT_INTERVAL 30 //网络请求超时时间
#ifndef _GTMDevLog

#ifdef DEBUG
#define baseURL @""
#else
#define baseURL @""
#endif

#endif



#define NETReturnErrorCode 89999 //服务器报错的
#define NETWorkErrorCode 90000 //手机显示无网络
#define WebWorkErrorString @"服务器累了，暂时无法提供功能"
#define NETWorkErrorString @"网络连接失败，请检查您的网络"
#define PAGE_NUM 20 //分页请求的页数

#endif /* Macros_h */
