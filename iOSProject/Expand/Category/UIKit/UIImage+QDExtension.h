//
//  UIImage+QDExtension.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QDExtension)


+(UIImage *)imageWithName:(NSString *)name;

+ (UIImage *)imageNamed:(NSString *)name renderingMode:(UIImageRenderingMode)renderingMode;
@end

NS_ASSUME_NONNULL_END
