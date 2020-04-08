//
//  UIButton+QDExtension.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/14.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "UIButton+QDExtension.h"

@implementation UIButton (QDExtension)
- (void)changeBtnCanSelectedStatu:(BOOL)enable{
    self.enabled = enable;
    if (enable) {
        self.backgroundColor = QDColorMain;
    }else{
        self.backgroundColor = QDColorBtnDisSelectedColor;
    }
}
@end
