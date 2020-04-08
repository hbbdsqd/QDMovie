//
//  QDCateListView.m
//  iOSProject
//
//  Created by 苏秋东 on 2020/2/12.
//  Copyright © 2020 苏秋东. All rights reserved.
//

#import "QDCateListView.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
@interface QDCateListView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;
@property (nonatomic,assign) BOOL isNoMoreData;
@end

@implementation QDCateListView{
    NSInteger pi;
    BOOL isBottom;
}

- (void)dealloc
{
    self.scrollCallback = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        pi = 1;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.tableView.backgroundColor = QDGetColor(@"ffffff");
        self.tableView.tableFooterView = [UIView new];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.dataSource = [NSMutableArray array];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
        [self.tableView registerNib:[UINib nibWithNibName:@"QDMovieListTableViewCell" bundle:nil] forCellReuseIdentifier:@"QDMovieListTableViewCell"];
        self.tableView.showsHorizontalScrollIndicator = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.tableHeaderView = [[UIView alloc] init];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)headerRefresh{
    pi = 1;
    self.isNoMoreData = NO;
    [self getData];
}

- (void)footerRefresh{
    if (self.isNoMoreData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    pi++;
    [self getData];
}

- (void)getData{
    //     http://www.zuidazy5.net/?m=vod-type-id-6-pg-2.html
    NSString * urlStr = [NSString stringWithFormat:@"http://www.zuidazy5.net/?m=vod-type-id-%@-pg-%ld.html",self.type,(long)pi];
    QDShowLoading;
    __weak typeof(self) weakSelf = self;
    [[QDBaseSever sharedClient] SeverGET:urlStr parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            QDHideHud;
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
        NSString *nameStr =  [[NSString alloc]initWithData: responseObject encoding:NSUTF8StringEncoding];
        
        [weakSelf changeData:nameStr];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            QDHideHud;
            QDShowMessage([error localizedDescription]);
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
}

- (void)changeData:(NSString *)dataStr{
    
    NSData *xmlData=[dataStr dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:xmlData];
    NSArray *titleArray=[xpathParser searchWithXPathQuery:@"//span[@class='xing_vb4']"];
    if (titleArray.count > 0) {
        if (pi == 1) {
            self.dataSource = [NSMutableArray array];
        }
        self.isNoMoreData = NO;
    }else{
        self.isNoMoreData = YES;
    }
    for (TFHppleElement *ele in titleArray) {
        if (ele.hasChildren) {
            QDMovieListModel * model = [QDMovieListModel new];
            TFHppleElement * subEle = [ele firstChild];
            model.movieUrl = [NSString stringWithFormat:@"http://www.zuidazy5.net%@",[CommonTools getStringWithDic:subEle.attributes key:@"href"]];
            model.movieName = subEle.content;
            [self.dataSource addObject:model];
        }
    }
    NSArray *cateArray=[xpathParser searchWithXPathQuery:@"//span[@class='xing_vb5']"];
    NSInteger index = self.dataSource.count - cateArray.count;
    for (TFHppleElement *ele in cateArray) {
        if (self.dataSource.count > index) {
            QDMovieListModel * model = self.dataSource[index];
            model.movieCate = ele.content;
            index++;
        }
    }
    
    NSArray *timeArray=[xpathParser searchWithXPathQuery:@"//span[@class='xing_vb6'] | //span[@class='xing_vb7']"];
    index = self.dataSource.count - timeArray.count;
    for (TFHppleElement *ele in timeArray) {
        if (self.dataSource.count > index) {
            QDMovieListModel * model = self.dataSource[index];
            model.movieTime = ele.content;
            index++;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}
#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QDMovieListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QDMovieListTableViewCell"];
    
    QDMovieListModel * model = self.dataSource[indexPath.row];
    
    cell.nameLab.text = model.movieName;
    cell.cateLab.text = model.movieCate;
    if (model.movieTime.length > 10) {
        model.movieTime = [model.movieTime substringToIndex:10];
    }
    cell.timeLab.text = model.movieTime;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QDMovieListModel * model = self.dataSource[indexPath.row];
    QDMovieMainViewController * vc = [[QDMovieMainViewController alloc]init];
    vc.title = model.movieName;
    vc.movieUrl = model.movieUrl;
    [self.naviController pushViewController:vc animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback?:self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView {
    return self;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)listDidAppear {
    NSLog(@"listDidAppear");
    if (!_isFirstLoad) {
        _isFirstLoad = YES;
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)listDidDisappear {
    NSLog(@"listDidDisappear");
}

- (void)listViewLoadDataIfNeeded {
    
}
@end
