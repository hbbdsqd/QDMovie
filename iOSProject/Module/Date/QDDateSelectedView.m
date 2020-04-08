//
//  QDDateSelectedView.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/7.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDDateSelectedView.h"

@implementation QDDateSelectedView
+ (void)showDateWithMode:(UIDatePickerMode)mode viewController:(UIViewController *)vc dateBlock:(void(^)(NSDate * date))dateBlock{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = mode;
    datePicker.frame = CGRectMake(0, 10, vc.view.width, datePicker.height);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //增加子控件--直接添加到alert的view上面
    [alert.view addSubview:datePicker];
    //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        dateBlock(datePicker.date);
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [alert addAction:ok];//添加按钮
    [alert addAction:cancel];//添加按钮
    //以modal的形式
    [vc presentViewController:alert animated:YES completion:^{ }];
}
@end
