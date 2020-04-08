//
//  NSObject+NGExtension.m
//  SSApp
//
//  Created by 苏秋东 on 2019/6/29.
//  Copyright © 2019 哪逛. All rights reserved.
//

#import "NSObject+NGExtension.h"

@implementation NSObject (NGExtension)
- (BOOL)isNull{
    BOOL isNull = NO;
    if(self == nil || [self isKindOfClass:[NSNull class]]){
        isNull = YES;
    }
    return isNull;
}

- (BOOL)isArray{
    BOOL isArray = YES;
    if([self isNull]){
        isArray = NO;
    }else if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]]){
        isArray = YES;
    }else{
        return isArray = NO;
    }
    return isArray;
}

- (BOOL)isDictionary{
    BOOL isDictionary = YES;
    if([self isNull]){
        isDictionary = NO;
    }else if ([self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSMutableDictionary class]]){
        isDictionary = YES;
    }else{
        return isDictionary = NO;
    }
    return isDictionary;
}
@end
