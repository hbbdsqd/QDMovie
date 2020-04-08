//
//  QDHomeViewController.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDHomeViewController.h"
#import "QDHomeSectionView.h"
#import "QDMovieListModel.h"
#import "QDMovieListTableViewCell.h"
#import "QDMovieMainViewController.h"
#import "QDSearchViewController.h"
#import "QDCateListViewController.h"

@interface QDHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QDHomeViewController{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QDMovieListTableViewCell" bundle:nil] forCellReuseIdentifier:@"QDMovieListTableViewCell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = [[UIView alloc] init];
    [self addRefreshWithTableView:self.tableView];
    
    [self creatSearchBtn];
    
    [self getData];
    
    [self showAlert];
}

- (void)showAlert{
    BOOL noFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"noFirst"];
    if (noFirst) {
        return;
    }
    NSString * contents = @"感谢您对电影宝的信任，我们将按法律法规要求，采取严格的安全保护措施，保护您的个人隐私信息。在使用我方产品或服务前，请您务必仔细阅读《隐私权政策》，详细了解我方收集、存储、使用、披露和保护您的个人信息的举措，进而帮助您更好地保护您的隐私。\n【请您注意】如果您不同意本隐私政策的任何内容，请您停止注册。您停止注册后将仅可以浏览我们的商品信息和直播信息但无法享受我们的产品或服务。\n如您按照注册流程提示填写信息、阅读并点击同意上述协议且完成全部注册流程后，即表示您充分阅读、理解、并接受协议的全部内容；如您对以上协议内容有任何疑问，您可随时与电影宝联系。";
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"用户隐私提示" message:contents preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"noFirst"];
    }];
    
    [alertVC addAction:cancle];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:YES completion:nil];

}

- (void)getData{
//    http://www.zuidazy5.net/?m=vod-index-pg1.html
    NSString * urlStr = [NSString stringWithFormat:@"http://www.zuidazy5.net/?m=vod-index-pg-%ld.html",(long)self.page_num];
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
 
- (void)leftBtnClcik{
    QDSearchViewController * vc = [[QDSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak typeof(self) weakSelf = self;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, QDScreen_Width, 100)];
    QDHomeSectionView * sectionView = [QDHomeSectionView loadView];
    sectionView.frame = view.bounds;
    [view addSubview:sectionView];
    [sectionView setCateBtnClickBlock:^(NSInteger type) {
        QDCateListViewController * vc = [[QDCateListViewController alloc]init];
        vc.type = type;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    return view;
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}
@end
