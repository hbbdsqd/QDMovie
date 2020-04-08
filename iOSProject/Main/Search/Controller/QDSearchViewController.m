//
//  QDSearchViewController.m
//  iOSProject
//
//  Created by 苏秋东 on 2020/2/12.
//  Copyright © 2020 苏秋东. All rights reserved.
//

#import "QDSearchViewController.h"
#import "QDMovieListTableViewCell.h"
#import "QDMovieListModel.h"

@interface QDSearchViewController ()<UISearchBarDelegate>
@property (nonatomic,assign) BOOL isSearched;
@end

@implementation QDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    NSMutableArray * searchArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchArray"];
    if ([searchArray isArray]) {
        searchArray = [NSMutableArray arrayWithArray:searchArray];
    }else{
        searchArray = [NSMutableArray array];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:searchArray forKey:@"searchArray"];
    self.searchBarTop.constant = QDStatusBarHeight;
    [self addRefreshWithTableView:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = [[UIView alloc] init];
    self.tableView.hidden = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QDMovieListTableViewCell" bundle:nil] forCellReuseIdentifier:@"QDMovieListTableViewCell"];
    [self.searchBar becomeFirstResponder];
    [self loadTagView];
}
- (IBAction)delTagBtnClick:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[NSMutableArray array] forKey:@"searchArray"];
    self.tagView.tagTexts = [NSMutableArray array];
}

- (void)loadTagView{
    _tagView = [[SQButtonTagView alloc]initWithTotalTagsNum:20
                                                  viewWidth:QDScreen_Width-24
                                                    eachNum:0
                                                    Hmargin:12
                                                    Vmargin:10
                                                  tagHeight:26
                                                tagTextFont:[UIFont systemFontOfSize:13.f]
                                               tagTextColor:[UIColor colorWithHexString:@"161A1A"]
                                       selectedTagTextColor:[UIColor colorWithHexString:@"161A1A"]
                                    selectedBackgroundColor:QDGetColor(@"f4f7f7")];
    _tagView.maxSelectNum = 1;
    __weak typeof(self) weakSelf = self;
    
    _tagView.selectBlock = ^(SQButtonTagView * _Nonnull tagView, NSArray * _Nonnull selectArray, NSString * _Nonnull text) {
        weakSelf.searchBar.text=text;
        [weakSelf getData];
    };
    _tagView.tagTexts=[[NSUserDefaults standardUserDefaults] objectForKey:@"searchArray"];
    _tagView.frame = CGRectMake(self.titleLab.left, self.titleLab.bottom + 20, QDScreen_Width - 24, 400);
    [self.view addSubview:_tagView];
    [self.view sendSubviewToBack:_tagView];
    [self updateTagView];
}

- (void)updateTagView{
    
}



- (IBAction)cancleBtnClick:(id)sender {
    if (self.isSearched) {
        self.tableView.hidden = YES;
        self.isSearched = NO;
        self.searchBar.text = @"";
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([CommonTools isBlankString:searchBar.text]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            QDShowMessage(@"请输入要搜索的热门资源");
            return;
        });
    }
    self.page_num = 1;
    [self getData];
}

- (void)getData{
    if ([CommonTools isBlankString:self.searchBar
    .text]) {
        return;
    }
    
    NSMutableArray * searchArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchArray"];
    if ([searchArray isArray]) {
        searchArray = [NSMutableArray arrayWithArray:searchArray];
    }else{
        searchArray = [NSMutableArray array];
    }
    
    if (![searchArray containsObject:self.searchBar.text]) {
        [searchArray insertObject:self.searchBar.text atIndex:0];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:searchArray forKey:@"searchArray"];
    
    self.tagView.tagTexts = searchArray;
    
    [self.searchBar resignFirstResponder];
//    http://www.zuidazy5.net/?m=vod-index-pg1.html
    NSString * urlStr = [NSString stringWithFormat:@"http://www.zuidazy5.net/index.php?m=vod-search-pg-%ld-wd-%@.html",(long)self.page_num,[self.searchBar
                         .text jk_urlEncode]];
    
    QDShowLoading;
    __weak typeof(self) weakSelf = self;
    [[QDBaseSever sharedClient] SeverGET:urlStr parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            QDHideHud;
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            weakSelf.isSearched = YES;
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
        if (self.page_num == 1) {
            self.dataArray = [NSMutableArray array];
        }
        self.isNoMoreData = NO;
    }else{
        self.isNoMoreData = YES;
        self.dataArray = [NSMutableArray array];
    }
    for (TFHppleElement *ele in titleArray) {
        if (ele.hasChildren) {
            QDMovieListModel * model = [QDMovieListModel new];
            TFHppleElement * subEle = [ele firstChild];
            model.movieUrl = [NSString stringWithFormat:@"http://www.zuidazy5.net%@",[CommonTools getStringWithDic:subEle.attributes key:@"href"]];
            model.movieName = subEle.content;
            [self.dataArray addObject:model];
        }
    }
    NSArray *cateArray=[xpathParser searchWithXPathQuery:@"//span[@class='xing_vb5']"];
    NSInteger index = self.dataArray.count - cateArray.count;
    for (TFHppleElement *ele in cateArray) {
        if (self.dataArray.count > index) {
            QDMovieListModel * model = self.dataArray[index];
            model.movieCate = ele.content;
            index++;
        }
    }

    NSArray *timeArray=[xpathParser searchWithXPathQuery:@"//span[@class='xing_vb6'] | //span[@class='xing_vb7']"];
    index = self.dataArray.count - timeArray.count;
    for (TFHppleElement *ele in timeArray) {
        if (self.dataArray.count > index) {
            QDMovieListModel * model = self.dataArray[index];
            model.movieTime = ele.content;
            index++;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    });
}

- (void)headerRefresh{
    self.page_num = 1;
    self.isNoMoreData = NO;
    [self getData];
}

- (void)footerRefresh{
    if (self.isNoMoreData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    self.page_num++;
    [self getData];
}
  
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QDMovieListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QDMovieListTableViewCell"];
    
    QDMovieListModel * model = self.dataArray[indexPath.row];
    
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
    QDMovieListModel * model = self.dataArray[indexPath.row];
    QDMovieMainViewController * vc = [[QDMovieMainViewController alloc]init];
    vc.title = model.movieName;
    vc.movieUrl = model.movieUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
