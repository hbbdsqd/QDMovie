//
//  QDBaseSever.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/15.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "QDBaseSever.h"

@implementation QDBaseSever
+ (instancetype)sharedClient
{
    static QDBaseSever* _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[QDBaseSever alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.requestSerializer.timeoutInterval = TIMEOUT_INTERVAL;
        //        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        
        //  _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    });
    
    return _sharedClient;
}

- (NSURLSessionDataTask*)SeverPOST:(NSString*)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask* task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask* task, NSError* error))failure
{
    NSMutableDictionary * pars = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSLog(@"pars------%@",pars);
    return [super POST:URLString
            parameters:pars
              progress:nil
               success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable JSON) {
        NSLog(@"QDBaseSever:%@          URLString:%@",JSON,URLString);
        [self willSuccessRequestWithTask:task JSONData:JSON success:success failure:failure];
    }
               failure:failure];
}

- (NSURLSessionDataTask*)SeverGET:(NSString*)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask* task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask* task, NSError* error))failure
{
    
    NSMutableDictionary * pars = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSLog(@"pars------%@",pars);
    return [super GET:URLString
           parameters:pars
             progress:nil
              success:^(NSURLSessionDataTask* __unused task, id JSON) {
        [self willSuccessRequestWithTask:task JSONData:JSON success:success failure:failure];
    }
              failure:failure];
}

- (void)willSuccessRequestWithTask:(NSURLSessionDataTask* __unused)task
                          JSONData:(id)JSON
                           success:(void (^)(NSURLSessionDataTask* task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask* task, NSError* error))failure
{
    if (success) {
        success(task, JSON);
        return;
    }
    if (JSON == nil || (NSNull*)JSON == [NSNull null]) {
        if (failure) {
            NSDictionary* userInfo = [NSDictionary dictionaryWithObject:@"网络调用失败" forKey:NSLocalizedDescriptionKey];
            NSError* aError = [NSError errorWithDomain:@"QDBaseSever" code:1001 userInfo:userInfo];
            failure(task, aError);
        }
        return;
    }
    NSString* postsResponse = [JSON getValueForKey:@""];
    if ([CommonTools isBlankString:postsResponse]) {
        if (failure) {
            NSDictionary* userInfo = [NSDictionary dictionaryWithObject:@"网络请求失败" forKey:NSLocalizedDescriptionKey];
            NSError* aError = [NSError errorWithDomain:@"QDBaseSever" code:1002 userInfo:userInfo];
            failure(task, aError);
        }
        return;
    }
    
    if (success) {
        success(task, JSON);
        return;
    }
}

@end
