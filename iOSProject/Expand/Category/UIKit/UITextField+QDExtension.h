//
//  UITextField+QDExtension.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/14.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (QDExtension)<UITextFieldDelegate>

/**
 设置最大长度
 */
@property (nonatomic,assign) CGFloat maxLength;
@end

NS_ASSUME_NONNULL_END
