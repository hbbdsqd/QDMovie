//
//  QDNews3TableViewCell.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/7.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDNews3TableViewCell : QDBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UILabel *timelab;

@end

NS_ASSUME_NONNULL_END
