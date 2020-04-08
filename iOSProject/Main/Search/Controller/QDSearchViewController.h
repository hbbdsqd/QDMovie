//
//  QDSearchViewController.h
//  iOSProject
//
//  Created by 苏秋东 on 2020/2/12.
//  Copyright © 2020 苏秋东. All rights reserved.
//

#import "QDBaseViewController.h"
#import "SQButtonTagView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDSearchViewController : QDBaseViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarTop;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) SQButtonTagView *tagView;
@end

NS_ASSUME_NONNULL_END
