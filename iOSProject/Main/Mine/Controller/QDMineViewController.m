//
//  QDMineViewController.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDMineViewController.h"
#import "QDLoginMainViewController.h"
#import "QDMineAboutViewController.h"
#import "QDPrivacyViewController.h"
@interface QDMineViewController ()
@property (nonatomic,strong) NSMutableArray *titleArray;
@end

@implementation QDMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mineCell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = [[UIView alloc] init];
    self.titleArray = [NSMutableArray array];
    [self.titleArray addObject:@"给个好评"];
    [self.titleArray addObject:@"关于我们"];
    [self.titleArray addObject:@"隐私权限"];
//    [self.titleArray addObject:@"我的收藏"];
//    [self.titleArray addObject:@"分享"];
//    [self.titleArray addObject:@"搜索历史"];
}

#pragma mark - TableViewDelegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.titleArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * title = self.titleArray[indexPath.row];
    if ([title isEqualToString:@"给个好评"]) {
        NSString *itunesUrl = @"itms-apps://itunes.apple.com/cn/app/id1497532169?mt=8&action=write-review";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesUrl]];
    }else if ([title isEqualToString:@"关于我们"]){
        QDMineAboutViewController * vc = [[QDMineAboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"我的收藏"]){
        
    }else if ([title isEqualToString:@"分享"]){
        QDLoginMainViewController * vc = [[QDLoginMainViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"播放历史"]){
        
    }else if ([title isEqualToString:@"隐私权限"]){
        QDPrivacyViewController * vc = [[QDPrivacyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
