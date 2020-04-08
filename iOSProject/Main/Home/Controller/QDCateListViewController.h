//
//  QDCateListViewController.h
//  iOSProject
//
//  Created by 苏秋东 on 2020/2/12.
//  Copyright © 2020 苏秋东. All rights reserved.
//

#import "QDBaseViewController.h"
#import "JXCategoryTitleView.h"
#import "JXCategoryListContainerView.h"
#import "JXCategoryView.h"
NS_ASSUME_NONNULL_BEGIN
static const CGFloat JXOrderheightForHeaderInSection = 50;
@interface QDCateListViewController : QDBaseViewController

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

/// 1：电影 2：电视剧 3：综艺 4：动漫
@property (nonatomic,assign) NSInteger type;


@end

NS_ASSUME_NONNULL_END
