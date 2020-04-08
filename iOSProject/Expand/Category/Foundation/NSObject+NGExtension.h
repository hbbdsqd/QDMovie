//
//  NSObject+NGExtension.h
//  SSApp
//
//  Created by 苏秋东 on 2019/6/29.
//  Copyright © 2019 哪逛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NGExtension)

/// 判断是否为空
- (BOOL)isNull;

/// 判断是否是数组
- (BOOL)isArray;

/// 判断是否是字典
- (BOOL)isDictionary;
@end

NS_ASSUME_NONNULL_END
