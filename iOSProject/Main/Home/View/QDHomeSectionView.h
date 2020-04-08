//
//  QDHomeSectionView.h
//  iOSProject
//
//  Created by 苏秋东 on 2020/2/4.
//  Copyright © 2020 苏秋东. All rights reserved.
//

#import "QDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDHomeSectionView : QDBaseView
@property (weak, nonatomic) IBOutlet UIButton *movieBtn;
@property (weak, nonatomic) IBOutlet UIButton *tvBtn;
@property (weak, nonatomic) IBOutlet UIButton *varietyBtn;
@property (weak, nonatomic) IBOutlet UIButton *animeBtn;

@property (nonatomic, copy) void(^cateBtnClickBlock)(NSInteger type);

@end

NS_ASSUME_NONNULL_END
