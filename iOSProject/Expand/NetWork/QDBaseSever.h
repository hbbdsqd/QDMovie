//
//  QDBaseSever.h
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/15.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <AFNetworking/AFNetworking.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDBaseSever : AFHTTPSessionManager

+ (instancetype)sharedClient;
- (NSURLSessionDataTask*)SeverPOST:(NSString*)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask* task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask* task, NSError* error))failure;
- (NSURLSessionDataTask*)SeverGET:(NSString*)URLString
                  parameters:(NSDictionary *)parameters
                     success:(void (^)(NSURLSessionDataTask* task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask* task, NSError* error))failure;
@end

NS_ASSUME_NONNULL_END
