//
//  QDSelectedView.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/7.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDSelectedView : QDBaseView<UIScrollViewDelegate>
/**
 展示的内容组
 */
@property (nonatomic,strong) NSArray *titleArray;

/**
 滚动视图
 */
@property (nonatomic,strong) UIScrollView *scrollView;

/**
 内容宽度
 */
@property (nonatomic,assign) CGFloat titleWidth;

/**
 内容背景颜色
 */
@property (nonatomic,strong) UIColor *buttonBackGroundColor;

/**
 内容字体颜色
 */
@property (nonatomic,strong) UIColor *buttonTitleColor;

/**
 内容字体选中颜色
 */
@property (nonatomic,strong) UIColor *buttonSelectedTitleColor;

@property (nonatomic, copy) void(^selectedTitleBlock)(NSInteger index,NSString *title);

- (void)loadTitle;
@end

NS_ASSUME_NONNULL_END
