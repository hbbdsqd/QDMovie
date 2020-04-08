//
//  QDNews4TableViewCell.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/8.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDNews4TableViewCell : QDBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *keyLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;

@end

NS_ASSUME_NONNULL_END
