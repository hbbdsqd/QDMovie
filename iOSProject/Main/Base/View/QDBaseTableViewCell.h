//
//  QDBaseTableViewCell.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/27.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDBaseTableViewCell : UITableViewCell
- (void)configWithDic:(NSDictionary *)dic;
- (void)configWithArray:(NSArray *)array;
- (void)configWithModel:(id)baseModel;
- (void)configWithString:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
