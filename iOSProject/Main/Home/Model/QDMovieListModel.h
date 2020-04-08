//
//  QDMovieListModel.h
//  iOSProject
//
//  Created by 苏秋东 on 2020/2/4.
//  Copyright © 2020 苏秋东. All rights reserved.
//

#import "QDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDMovieListModel : QDBaseModel
@property (nonatomic,copy) NSString *movieName;
@property (nonatomic,copy) NSString *movieTime;
@property (nonatomic,copy) NSString *movieCate;
@property (nonatomic,copy) NSString *movieUrl;
@end

NS_ASSUME_NONNULL_END
