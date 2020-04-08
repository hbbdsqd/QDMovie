//
//  QDCateListView.h
//  iOSProject
//
//  Created by 苏秋东 on 2020/2/12.
//  Copyright © 2020 苏秋东. All rights reserved.
//

#import "QDBaseView.h"
#import "JXPageListView.h"
#import "QDMovieListModel.h"
#import "QDMovieListTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
@interface QDCateListView : QDBaseView <JXPageListViewListDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<QDMovieListModel *>  *dataSource;

@property (nonatomic,strong) QDBaseNavViewController *naviController;

@property (nonatomic,copy) NSString *type;

@property (nonatomic,assign) BOOL isFirstLoad;


@end

NS_ASSUME_NONNULL_END
