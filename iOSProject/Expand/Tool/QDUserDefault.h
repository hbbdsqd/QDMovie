//
//  QDUserDefault.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/28.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDUserDefault : NSObject

/**
 设置引导版本
 */
+ (void)setGuideVersion;

/**
 获取引导版本
 */
+ (NSString *)getGuideVersion;
@end

NS_ASSUME_NONNULL_END
