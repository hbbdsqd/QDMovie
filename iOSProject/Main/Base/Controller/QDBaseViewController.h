//
//  QDBaseViewController.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDBaseViewController : UIViewController
/**
 * 是否支持右滑返回，默认YES
 */
@property (nonatomic, assign) BOOL popGestureEnable;
//分⻚页数量量
@property (nonatomic,assign) NSInteger page_num;
//分⻚页⼤大⼩小
@property (nonatomic,assign) NSInteger page_size;

@property (nonatomic,assign) BOOL isNoMoreData;
//公共数组
@property (nonatomic,strong) NSMutableArray *dataArray;
//公共字典
@property (nonatomic,strong) NSMutableDictionary *dataDict;



#pragma mark ---------加载刷新控件
- (void)addRefreshWithTableView:(UITableView *)tableView;
- (void)headerRefresh;
- (void)footerRefresh;

- (UIBarButtonItem*)leftMenuBarButtonItem;

#pragma mark ---------加载无数据视图到指定view
/**
 *  在指定view显示搜索没有数据的视图
 */
- (void)showNoDataViewToView:(UIView*)superview withString:(NSString*)string;

/**
 *  从指定view删除搜索没有数据的视图
 */
- (void)hideNoDataViewFromView:(UIView*)superview;

- (void)tapRefresh;

- (void)backPopViewcontroller:(id)sender;


#pragma mark ---------创建导航条左侧和右侧按钮根据文字和图片可自定义
- (void)creatLeftBtnOfCustomWithTitle:(NSString *)title;

- (void)creatLeftBtnOfCustomWithTitle:(NSString *)title textColor:(UIColor *)textColor;

- (void)creatLeftBtnOfCustomWithImage:(NSString *)imageName;

- (void)creatRightBtnOfCustomWithTitle:(NSString *)title;

- (void)creatRightBtnOfCustomWithTitle:(NSString *)title textColor:(UIColor *)textColor;

- (void)creatRightBtnOfCustomWithImage:(NSString *)imageName;

- (void)creatSearchBtn;
@end

NS_ASSUME_NONNULL_END
