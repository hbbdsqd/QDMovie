//
//  QDDateSelectedView.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/7.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import <Foundation/Foundation.h>
 
NS_ASSUME_NONNULL_BEGIN

@interface QDDateSelectedView : NSObject

+ (void)showDateWithMode:(UIDatePickerMode)mode viewController:(UIViewController *)vc dateBlock:(void(^)(NSDate * date))dateBlock;

@end

NS_ASSUME_NONNULL_END
