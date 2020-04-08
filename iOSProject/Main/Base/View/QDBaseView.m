//
//  QDBaseView.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/4/7.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseView.h"

@implementation QDBaseView
+(instancetype)loadView{
    NSString *className = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].firstObject;
}
@end
