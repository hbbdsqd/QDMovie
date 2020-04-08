//
//  UITextField+QDExtension.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/14.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "UITextField+QDExtension.h"

@implementation UITextField (QDExtension)
- (CGFloat)maxLength{
    if ([objc_getAssociatedObject(self, _cmd) floatValue] == 0) {
        return 999;
    }
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setMaxLength:(CGFloat)maxLength{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification"
                                              object:self];
    objc_setAssociatedObject(self, @selector(maxLength), @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"textField.text------%@",textField.text);
    return YES;
}
-(void)textFiledEditChanged:(NSNotification *)obj{
    
    //当前输入语言状态
    UITextInputMode *mode = (UITextInputMode *)[UITextInputMode activeInputModes][0];
    NSString *lang = mode.primaryLanguage;
    
    //汉字
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        //高亮状态的start位置
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮状态，即每次截取要在文字确认之后
        if (!position) {
            
            if (self.text.length > self.maxLength) {
                self.text = [self.text substringToIndex:self.maxLength];
                
            }
        }
    }
    //非汉字状态
    else{
        
        if (self.text.length > self.maxLength) {
            self.text = [self.text substringToIndex:self.maxLength];
            
        }
    }
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:self];
}
@end
