//
//  QDMovieMainViewController.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/16.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDMovieMainViewController.h"
#import "QDMovieListModel.h"
#import "ZFFullScreenViewController.h"
@interface QDMovieMainViewController ()

@end

@implementation QDMovieMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pointLab cornerAllCornersWithCornerRadius:self.pointLab.height * 0.5];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"QDMovieMainViewControllerCell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = [[UIView alloc] init];
    [self getData];
}
- (void)getData{
    QDShowLoading;
    __weak typeof(self) weakSelf = self;
    [[QDBaseSever sharedClient] SeverGET:self.movieUrl parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            QDHideHud;
        });
        NSString *nameStr =  [[NSString alloc]initWithData: responseObject encoding:NSUTF8StringEncoding];
 
        [weakSelf changeData:nameStr];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            QDHideHud;
            QDShowMessage([error localizedDescription]); 
        });
    }];
}

- (void)changeData:(NSString *)dataStr{
    NSData *xmlData=[dataStr dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:xmlData];
    NSArray *imageArray=[xpathParser searchWithXPathQuery:@"//img[@class='lazy']"];
    for (TFHppleElement *ele in imageArray) {
        [self.movieImageView sd_setImageWithURL:[NSURL URLWithString:[CommonTools getStringWithDic:ele.attributes key:@"src"]] placeholderImage:QDGetImage(@"placeholderImage2")];
    }
    
    
    NSArray *levelArray=[xpathParser searchWithXPathQuery:@"//div[@class='vodh']"];
    for (TFHppleElement *ele in levelArray) {
        if (ele.hasChildren) {
            for (TFHppleElement * subEle in ele.children) {
                if ([subEle.tagName isEqualToString:@"span"]) {
                    self.levelLab.text = subEle.content;
                }else if ([subEle.tagName isEqualToString:@"label"]){
                    self.pointLab.text = subEle.content;
                }else if ([subEle.tagName isEqualToString:@"h2"]){
                    self.title = subEle.content;
                }
            }
        }
    }
     
    
    NSArray *infoArray=[xpathParser searchWithXPathQuery:@"//div[@class='vodinfobox']"];
    for (TFHppleElement *ele in infoArray) {
        if (ele.hasChildren) {
            TFHppleElement * subEle = ele.children[1];
            if (subEle.hasChildren) {
                for (TFHppleElement *itemEle in subEle.children) {
                    if ([itemEle.content containsString:@"导演"]) {
                        self.directorLab.text = itemEle.content;
                    }else if ([itemEle.content containsString:@"主演"]){
                        self.userLab.text = itemEle.content;
                    }else if ([itemEle.content containsString:@"类型"]){
                        self.cateLab.text = itemEle.content;
                    }
                }
            }
        }
    }
    
    NSArray *smArray=[xpathParser searchWithXPathQuery:@"//li[@class='sm']"];
    for (TFHppleElement *ele in smArray) {
        if ([ele.content containsString:@"地区"]) {
            self.areaLab.text = ele.content;
        }else if ([ele.content containsString:@"语言"]){
            self.languageLab.text = ele.content;
        }else if ([ele.content containsString:@"上映"]){
            self.timeLab.text = ele.content;
        }
    }
    
    NSArray *contentArray=[xpathParser searchWithXPathQuery:@"//span[@class='more']"];
    for (TFHppleElement *ele in contentArray) {
        self.contentTextView.text = [CommonTools getStringWithDic:ele.attributes key:@"txt"];
    }
    
    NSArray * listArray=[xpathParser searchWithXPathQuery:@"//div[@id='play_1']//li"];
    for (TFHppleElement *ele in listArray) {
        QDMovieListModel * model = [QDMovieListModel new];
        NSArray * arr = [ele.content componentsSeparatedByString:@"$"];
        model.movieName = [arr firstObject];
        if (ele.hasChildren) {
            for (TFHppleElement * subEle in ele.children) {
                if ([subEle.tagName isEqualToString:@"input"]) {
                    model.movieUrl = [CommonTools getStringWithDic:subEle.attributes key:@"value"];
                }
            }
        }
        [self.dataArray addObject:model];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - TableViewDelegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QDMovieMainViewControllerCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    QDMovieListModel * model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.movieName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QDMovieListModel * model = self.dataArray[indexPath.row];
    
    ZFFullScreenViewController * vc = [[ZFFullScreenViewController alloc]init];
    vc.movieUrl = model.movieUrl;
    vc.movieName = model.movieName;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
