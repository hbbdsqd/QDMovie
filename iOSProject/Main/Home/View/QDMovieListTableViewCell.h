//
//  QDMovieListTableViewCell.h
//  iOSProject
//
//  Created by 苏秋东 on 2020/2/4.
//  Copyright © 2020 苏秋东. All rights reserved.
//

#import "QDBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDMovieListTableViewCell : QDBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *cateLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

NS_ASSUME_NONNULL_END
