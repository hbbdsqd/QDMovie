//
//  QDBaseModel.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/27.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseModel.h"

@implementation QDBaseModel
//判断去空赋值@“”
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([self isEmpty:oldValue]) {
        return  @"";
    }
    return oldValue;
}
- (BOOL)isEmpty:(NSString*)text{
    if ([text isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([text isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (text == nil){
        return YES;
    }
    return NO;
}
@end
