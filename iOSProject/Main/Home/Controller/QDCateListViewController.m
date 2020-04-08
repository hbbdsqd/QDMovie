//
//  QDCateListViewController.m
//  iOSProject
//
//  Created by 苏秋东 on 2020/2/12.
//  Copyright © 2020 苏秋东. All rights reserved.
//

#import "QDCateListViewController.h"
#import "QDCateListView.h"
#import "QDSearchViewController.h"
@interface QDCateListViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation QDCateListViewController{
    NSMutableArray *_titles;
    NSMutableArray *_typeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefault];
    
    [self creatRightBtnOfCustomWithImage:@"Nav_left_icon_search_balck"];
}

- (void)rightBtnClcik{
    QDSearchViewController * vc = [[QDSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadDefault{
    _titles = [NSMutableArray array];
    _typeArray = [NSMutableArray array];
    /// 1：电影 2：电视剧 3：综艺 4：动漫

    switch (self.type) {
        case 1:
        {
            self.title = @"电影资源";
            [_titles addObject:@"全部"];
            [_typeArray addObject:@"1"];
            [_titles addObject:@"动作片"];
            [_typeArray addObject:@"5"];
            [_titles addObject:@"喜剧片"];
            [_typeArray addObject:@"6"];
            [_titles addObject:@"爱情片"];
            [_typeArray addObject:@"7"];
            [_titles addObject:@"科幻片"];
            [_typeArray addObject:@"8"];
            [_titles addObject:@"恐怖片"];
            [_typeArray addObject:@"9"];
            [_titles addObject:@"剧情片"];
            [_typeArray addObject:@"10"];
            [_titles addObject:@"战争片"];
            [_typeArray addObject:@"11"];
            [_titles addObject:@"纪录片"];
            [_typeArray addObject:@"22"];
        }
            break;
        case 2:
        {
            self.title = @"电视资源";
            [_titles addObject:@"全部"];
            [_typeArray addObject:@"2"];
            [_titles addObject:@"国产"];
            [_typeArray addObject:@"12"];
            [_titles addObject:@"香港"];
            [_typeArray addObject:@"13"];
            [_titles addObject:@"韩国"];
            [_typeArray addObject:@"14"];
            [_titles addObject:@"欧美"];
            [_typeArray addObject:@"15"];
            [_titles addObject:@"日本"];
            [_typeArray addObject:@"19"];
            [_titles addObject:@"台湾"];
            [_typeArray addObject:@"20"];
            [_titles addObject:@"海外"];
            [_typeArray addObject:@"21"];
        }
            break;
        case 3:
        {
            self.title = @"综艺资源";
            [_titles addObject:@"全部"];
            [_typeArray addObject:@"3"];
        }
            break;
        case 4:
        {
            self.title = @"动漫资源";
            [_titles addObject:@"全部"];
            [_typeArray addObject:@"4"];
        }
            break;
            
        default:
            break;
    }
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXOrderheightForHeaderInSection)];
    self.categoryView.titles = _titles;
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleSelectedFont=QDGetPFSemiboldFont(18);
    self.categoryView.titleSelectedColor=QDColoeCategorySelected;
    self.categoryView.titleFont=QDGetPFRegularFont(14);
    self.categoryView.titleColor=QDColoeCategoryNotSelected;
    self.categoryView.backgroundColor=QDGetColor(@"f4f4f4");
    //添加分割线，这个完全自己配置
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = 15;
    lineView.indicatorLineViewColor=QDColorMain;
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView.didAppearPercent = 0.01; //滚动一点就触发加载
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listContainerView.frame = CGRectMake(0, JXOrderheightForHeaderInSection, self.view.width, self.view.height - JXOrderheightForHeaderInSection - QDSafeAreaBottomHeight);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryBaseView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return JXOrderheightForHeaderInSection;
}

- (id<JXCategoryListContentViewDelegate>)preferredListAtIndex:(NSInteger)index { 
    QDCateListView * view = [[QDCateListView alloc]init];
    view.naviController = (QDBaseNavViewController *)self.navigationController;
    view.type = _typeArray[index];
    return view;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
    }
    return _listContainerView;
}


#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    id<JXCategoryListContentViewDelegate> list = [self preferredListAtIndex:index];
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return _titles.count;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
