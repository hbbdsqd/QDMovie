//
//  QDMovieMainViewController.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/16.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDMovieMainViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDMovieMainViewController : QDBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy) NSString *movieUrl;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *levelLab;
@property (weak, nonatomic) IBOutlet UILabel *pointLab;
@property (weak, nonatomic) IBOutlet UILabel *directorLab;
@property (weak, nonatomic) IBOutlet UILabel *userLab;
@property (weak, nonatomic) IBOutlet UILabel *cateLab; 
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *languageLab;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
