//
//  QDMineViewController.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDMineViewController : QDBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
