//
//  QDGuideViewController.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/28.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDGuideViewController : QDBaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property (weak, nonatomic) IBOutlet UIButton *goHomeBtn;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

NS_ASSUME_NONNULL_END
