//
//  QDNews2TableViewCell.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/7.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDNews2TableViewCell : QDBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;

@end

NS_ASSUME_NONNULL_END
