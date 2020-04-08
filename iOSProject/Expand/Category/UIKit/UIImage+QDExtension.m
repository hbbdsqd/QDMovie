//
//  UIImage+QDExtension.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "UIImage+QDExtension.h"

@implementation UIImage (QDExtension)

+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = nil;
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (UIImage *)imageNamed:(NSString *)name renderingMode:(UIImageRenderingMode)renderingMode {
    UIImage *image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:renderingMode];
    return image;
}
@end
