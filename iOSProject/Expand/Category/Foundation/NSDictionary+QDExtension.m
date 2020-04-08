//
//  NSDictionary+QDExtension.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/14.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "NSDictionary+QDExtension.h"

@implementation NSDictionary (QDExtension)

- (NSString *)getValueForKey:(NSString *)key{
    if ([[self valueForKeyPath:key] isKindOfClass:[NSString class]]) {
        if ([CommonTools isBlankString:[self valueForKeyPath:key]]) {
            return @"";
        } else {
            return [NSString stringWithFormat:@"%@",[self valueForKeyPath:key]];
        }
    }else{
        if ([self valueForKeyPath:key] == nil || [self valueForKeyPath:key] == NULL) {
            return @"";
        }
        if ([[self valueForKeyPath:key] isKindOfClass:[NSNull class]]) {
            return @"";
        }
        return [NSString stringWithFormat:@"%@",[self valueForKeyPath:key]];
    }
}
@end
