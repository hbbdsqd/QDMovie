//
//  QDUserDefault.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/28.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDUserDefault.h"

@implementation QDUserDefault
+ (void)setGuideVersion{
    [[NSUserDefaults standardUserDefaults] setObject:QDGuideVersion forKey:@"QDGuideVersion"];
}
+ (NSString *)getGuideVersion{
    NSString * guideVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"QDGuideVersion"];
    if ([CommonTools isBlankString:guideVersion]) {
        guideVersion = @"";
    }
    return guideVersion;
}
@end
