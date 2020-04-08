//
//  QDNews1TableViewCell.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/7.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDNews1TableViewCell : QDBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *authorLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@end

NS_ASSUME_NONNULL_END
